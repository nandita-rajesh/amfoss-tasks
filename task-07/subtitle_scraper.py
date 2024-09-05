import os
import time
import requests
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from urllib.parse import urljoin
import hashlib

def get_imdb_id(movie_file):
    return "0059646"  # Example

def compute_hash(file_path):
    """Compute the hash of the given file for hash-based matching."""
    hash_md5 = hashlib.md5()
    with open(file_path, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

def scrape_subtitles(imdb_id, language, file_size=None, match_by_hash=None):
    if not imdb_id:
        print("No IMDb ID found. Please check the movie filename.")
        return []

    url = f"https://www.opensubtitles.org/en/search2/sublanguageid-{language}/imdbid-{imdb_id}/sort-7"

    chrome_options = Options()
    chrome_options.add_argument("--headless") 
    driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()), options=chrome_options)
    
    driver.get(url)
    
    time.sleep(10) 

    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    time.sleep(5) 

    soup = BeautifulSoup(driver.page_source, 'html.parser')
    driver.quit()

    rows = soup.select("table#search_results tbody tr")
    print(f"Number of rows found: {len(rows)}")

    subtitles = []
    seen_links = set() 
    seen_titles = set()  

    for row in rows:
        title_element = row.select_one("td a[href^='/en/subtitles/']")
        if not title_element:
            continue

        title = title_element.get_text(strip=True)
        if title in seen_titles: 
            continue
        seen_titles.add(title)

        subtitle_data = {
            "title": title,
            "link": urljoin("https://www.opensubtitles.org", title_element['href'])
        }

        language_element = row.select_one("td a[href^='/en/search/imdbid-']")
        subtitle_data["language"] = language_element.get_text(strip=True) if language_element else "N/A"

        date_element = row.select_one("td time")
        subtitle_data["date"] = date_element.get_text(strip=True) if date_element else "N/A"

        download_link_element = row.select_one("td a[href^='/en/subtitleserve/']")
        if download_link_element:
            full_download_link = urljoin("https://www.opensubtitles.org", download_link_element['href'])
            if full_download_link not in seen_links:
                seen_links.add(full_download_link)
                subtitle_data["download_link"] = full_download_link
                
                if file_size:
                    size_str = row.select_one("td.size").get_text(strip=True) if row.select_one("td.size") else None
                    if size_str and "MB" in size_str:  
                        size_in_mb = float(size_str.replace("MB", "").strip())
                        if size_in_mb > file_size:
                            print(f"Skipping {title} due to size {size_in_mb}MB > {file_size}MB")
                            continue
                
                subtitles.append(subtitle_data)

    return subtitles

def main(movie_file, language, output, file_size=None, match_by_hash=None):
    imdb_id = get_imdb_id(movie_file)
    print(f"Extracted IMDb ID: {imdb_id}")

    if not imdb_id:
        print("Failed to extract IMDb ID from the movie file.")
        return

    if match_by_hash:
        file_hash = compute_hash(movie_file)
        print(f"Computed hash for {movie_file}: {file_hash}")
    
    subtitles = scrape_subtitles(imdb_id, language, file_size, match_by_hash)

    if not subtitles:
        print("No subtitles found for the provided criteria.")
        return

    os.makedirs(output, exist_ok=True)
    downloaded_files = set() 

    for subtitle in subtitles:
        if "download_link" in subtitle:
            subtitle_title = subtitle["title"].replace("/", "_").replace(":", "_").replace("(", "").replace(")", "").strip()
            subtitle_file = os.path.join(output, f"{imdb_id}_{subtitle_title}_{subtitle['language']}.srt")

            if subtitle_file in downloaded_files:
                print(f"File already exists: {subtitle_file}")
                continue

            print(f"Attempting to download: {subtitle_file}")

            subtitle_response = requests.get(subtitle["download_link"], stream=True)
            if subtitle_response.status_code == 200:
                with open(subtitle_file, "wb") as file:
                    for chunk in subtitle_response.iter_content(chunk_size=8192):
                        if chunk:
                            file.write(chunk)
                downloaded_files.add(subtitle_file)  # Add to the set of downloaded files
                print(f"Downloaded: {subtitle_file}")
            else:
                print(f"Failed to download: {subtitle_file} (HTTP Status: {subtitle_response.status_code})")

if __name__ == "__main__":
    movie_file = "plan-9-from-outer-space.mp4"
    language = "eng"  
    output = "./subtitles"
    file_size = 2.0  
    match_by_hash = True 

    main(movie_file, language, output, file_size, match_by_hash)
