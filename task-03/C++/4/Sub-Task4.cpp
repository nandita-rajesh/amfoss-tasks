#include <iostream>
#include <fstream>
#include <iomanip> 

void generate_diamond(int n, std::ofstream& output_file) {
    for (int i = 0; i < n; ++i) {
        output_file << std::setw(n - i) << std::setfill(' ') << "" << std::setw(2 * i + 1) << std::setfill('*') << "" << std::endl;
    }

    for (int i = n - 2; i >= 0; --i) {
        output_file << std::setw(n - i) << std::setfill(' ') << "" << std::setw(2 * i + 1) << std::setfill('*') << "" << std::endl;
    }
}

int main() {
    std::ifstream input_file("input.txt");
    if (!input_file) {
        std::cerr << "Error opening input file" << std::endl;
        return EXIT_FAILURE;
    }

    int n;
    if (!(input_file >> n)) {
        std::cerr << "Error reading the number from input file" << std::endl;
        return EXIT_FAILURE;
    }
    input_file.close();

    std::ofstream output_file("output.txt");
    if (!output_file) {
        std::cerr << "Error opening output file" << std::endl;
        return EXIT_FAILURE;
    }

    generate_diamond(n, output_file);
    output_file.close();

    std::cout << "Pattern printed to output.txt" << std::endl;
    return EXIT_SUCCESS;
}
