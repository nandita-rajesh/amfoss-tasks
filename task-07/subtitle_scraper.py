import click
import os
import tempfile
import requests
import hashlib
from bs4 import BeautifulSoup
from imdb import IMDb

def get_imdb_id(filename):
    ia = IMDb()
    search = ia.search_movie(os.path.basename(filename))
    if search:
        return search[0].movieID
    return None

def get_movie_hash_and_size(filename):
    readsize = 64 * 1024
    with open(filename, 'rb') as f:
        size = os.path.getsize(filename)
        data = f.read(readsize)
        f.seek(-readsize, os.SEEK_END)
        data += f.read(readsize)
    return hashlib.md5(data).hexdigest(), size

def find_subtitles(filename, language, file_size=None, match_by_hash=False):
    imdb_id = get_imdb_id(filename)
    if not imdb_id:
        return []

    movie_hash, movie_size = get_movie_hash_and_size(filename) if match_by_hash else (None, None)
    
    search_url = f"https://www.opensubtitles.org/en/search2/sublanguageid-{language}/imdbid-{imdb_id}"
    if match_by_hash:
        search_url += f"/moviehash-{movie_hash}/moviesize-{movie_size}"

    response = requests.get(search_url)
    soup = BeautifulSoup(response.content, 'html.parser')

    subtitles = []
    for subtitle in soup.find_all('tr', class_='change'):
        subtitle_info = {
            'name': subtitle.find('td', class_='bnone').text.strip(),
            'language': language,
            'download_link': subtitle.find('a', {'id': 'bt-dwl-bt'})['href']
        }
        subtitles.append(subtitle_info)

    return sorted(subtitles, key=lambda x: x['name'])

def download_file(url, local_filename):
    response = requests.get(url, stream=True)
    total_size = int(response.headers.get('content-length', 0))
    with open(local_filename, 'wb') as f:
        for chunk in response.iter_content(chunk_size=1024):
            if chunk:
                f.write(chunk)
                # Show progress
                done = int(50 * f.tell() / total_size)
                print(f"\r[{'=' * done}{' ' * (50 - done)}] {f.tell() / 1024:.2f} KB / {total_size / 1024:.2f} KB", end='')
    print("\nDownload complete")

def download_subtitle(subtitle, output):
    subtitle_url = subtitle['download_link']
    subtitle_name = subtitle['name']
    local_filename = os.path.join(output, f"{subtitle_name}.srt")
    
    print(f"Downloading {subtitle_name}...")
    download_file(subtitle_url, local_filename)
    print(f"Downloaded {subtitle_name} to {output}")

@click.command()
@click.argument('input_path')
@click.option('-l', '--language', default='en', help='Filter subtitles by language.')
@click.option('-o', '--output', default='subtitles', type=click.Path(), help='Specify the output folder for the subtitles.')
@click.option('-s', '--file-size', type=int, help='Filter subtitles by movie file size.')
@click.option('-h', '--match-by-hash', is_flag=True, help='Match subtitles by movie hash.')
@click.option('-b', '--batch-download', is_flag=True, help='Enable batch mode.')
def main(input_path, language, output, file_size, match_by_hash, batch_download):
    if input_path.startswith("http://") or input_path.startswith("https://"):
        response = requests.get(input_path, stream=True)
        with tempfile.NamedTemporaryFile(delete=False, suffix=".mp4") as temp_file:
            for chunk in response.iter_content(chunk_size=1024):
                if chunk:
                    temp_file.write(chunk)
            temp_filename = temp_file.name
        click.echo(f"Downloaded temporary video file to {temp_filename}")
        
        subtitles = find_subtitles(temp_filename, language, file_size, match_by_hash)
        os.remove(temp_filename)
        
    elif os.path.isdir(input_path) and batch_download:
        for movie_file in os.listdir(input_path):
            if movie_file.endswith(".mp4"):
                subtitles = find_subtitles(os.path.join(input_path, movie_file), language, file_size, match_by_hash)
                if subtitles:
                    download_subtitle(subtitles[0], output)
        return
    else:
        subtitles = find_subtitles(input_path, language, file_size, match_by_hash)
    
    if subtitles:
        for idx, subtitle in enumerate(subtitles):
            click.echo(f"{idx + 1}. {subtitle['name']} - {subtitle['language']}")
        
        choice = click.prompt("Choose a subtitle to download", type=int)
        selected_subtitle = subtitles[choice - 1]
        download_subtitle(selected_subtitle, output)
    else:
        click.echo("No subtitles found.")

if __name__ == '__main__':
    main()
