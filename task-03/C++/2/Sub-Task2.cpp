#include <iostream>
#include <fstream>
#include <sstream>

void read_and_write_file(const std::string& input_file, const std::string& output_file) {
    std::ifstream input(input_file);
    if (!input.is_open()) {
        std::cerr << "Error opening input file: " << input_file << std::endl;
        return;
    }

    std::stringstream buffer;
    buffer << input.rdbuf();

    input.close();

    std::ofstream output(output_file);
    if (!output.is_open()) {
        std::cerr << "Error opening output file: " << output_file << std::endl;
        return;
    }

    output << buffer.str();

    output.close();

    std::cout << "Content successfully copied from " << input_file << " to " << output_file << "." << std::endl;
}

int main() {
    read_and_write_file("input.txt", "output.txt");
    return 0;
}
