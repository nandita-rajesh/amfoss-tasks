def read_and_write_file(input_file, output_file):
    try:
        with open(input_file, 'r') as infile:
            content = infile.read()
        
        with open(output_file, 'w') as outfile:
            outfile.write(content)
        
        print("Content successfully copied from {} to {}.".format(input_file, output_file))
    
    except FileNotFoundError:
        print("One of the files was not found. Please ensure '{}' and '{}' exist.".format(input_file, output_file))
    except IOError as e:
        print("An IOError occurred: {}".format(e))

if __name__ == "__main__":
    read_and_write_file('input.txt', 'output.txt')
