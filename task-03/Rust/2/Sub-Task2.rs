use std::fs::File;
use std::io::{self, Read, Write};

fn read_and_write_file(input_file: &str, output_file: &str) -> io::Result<()> {
    let mut input = File::open(input_file)?;
    let mut content = String::new();
    input.read_to_string(&mut content)?;
    
    let mut output = File::create(output_file)?;
    output.write_all(content.as_bytes())?;
    
    println!("Content successfully copied from {} to {}.", input_file, output_file);
    Ok(())
}

fn main() -> io::Result<()> {
    read_and_write_file("input.txt", "output.txt")
}
