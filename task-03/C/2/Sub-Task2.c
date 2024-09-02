#include <stdio.h>
#include <stdlib.h>

void read_and_write_file(const char *input_file, const char *output_file) {
    FILE *input = fopen(input_file, "r");
    if (input == NULL) {
        perror("Error opening input file");
        exit(EXIT_FAILURE);
    }

    FILE *output = fopen(output_file, "w");
    if (output == NULL) {
        perror("Error opening output file");
        fclose(input);
        exit(EXIT_FAILURE);
    }

    char buffer[1024];
    size_t bytes_read;

    while ((bytes_read = fread(buffer, 1, sizeof(buffer), input)) > 0) {
        if (fwrite(buffer, 1, bytes_read, output) != bytes_read) {
            perror("Error writing to output file");
            fclose(input);
            fclose(output);
            exit(EXIT_FAILURE);
        }
    }

    if (ferror(input)) {
        perror("Error reading from input file");
    }

    fclose(input);
    fclose(output);
    printf("Content successfully copied from %s to %s.\n", input_file, output_file);
}

int main() {
    read_and_write_file("input.txt", "output.txt");
    return 0;
}
