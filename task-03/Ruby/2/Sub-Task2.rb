def read_and_write_file(input_file, output_file)
    begin
      content = File.read(input_file)
      
      File.write(output_file, content)
      
      puts "Content successfully copied from #{input_file} to #{output_file}."
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end
  end
  
  read_and_write_file('input.txt', 'output.txt')
  