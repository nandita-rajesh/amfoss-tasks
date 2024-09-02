#include <stdio.h>
#include <stdlib.h>

void generate_diamond(int n, FILE *output_file) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            fputc(' ', output_file);
        }
        for (int j = 0; j < 2 * i + 1; j++) {
            fputc('*', output_file);
        }
        fputc('\n', output_file);
    }

    for (int i = n - 2; i >= 0; i--) {
        for (int j = 0; j < n - i - 1; j++) {
            fputc(' ', output_file);
        }
        for (int j = 0; j < 2 * i + 1; j++) {
            fputc('*', output_file);
        }
        fputc('\n', output_file);
    }
}

int main() {
    FILE *input_file = fopen("input.txt", "r");
    if (input_file == NULL) {
        perror("Error opening input file");
        return EXIT_FAILURE;
    }

    int n;
    if (fscanf(input_file, "%d", &n) != 1) {
        fprintf(stderr, "Error reading the number from input file.\n");
        fclose(input_file);
        return EXIT_FAILURE;
    }
    fclose(input_file);

    FILE *output_file = fopen("output.txt", "w");
    if (output_file == NULL) {
        perror("Error opening output file");
        return EXIT_FAILURE;
    }

    generate_diamond(n, output_file);

    fclose(output_file);
    printf("Pattern printed to output.txt\n");

    return EXIT_SUCCESS;
}
