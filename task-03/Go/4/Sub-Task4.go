package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func generateDiamond(n int) string {
	var builder strings.Builder

	for i := 0; i < n; i++ {
		builder.WriteString(strings.Repeat(" ", n-i-1))
		builder.WriteString(strings.Repeat("*", 2*i+1))
		builder.WriteString("\n")
	}

	for i := n - 2; i >= 0; i-- {
		builder.WriteString(strings.Repeat(" ", n-i-1))
		builder.WriteString(strings.Repeat("*", 2*i+1))
		builder.WriteString("\n")
	}

	return builder.String()
}

func main() {
	inputFile, err := os.Open("input.txt")
	if err != nil {
		fmt.Println("Error opening input file:", err)
		return
	}
	defer inputFile.Close()

	var n int
	scanner := bufio.NewScanner(inputFile)
	if scanner.Scan() {
		_, err := fmt.Sscanf(scanner.Text(), "%d", &n)
		if err != nil {
			fmt.Println("Error reading the number from input file:", err)
			return
		}
	}

	diamondPattern := generateDiamond(n)

	outputFile, err := os.Create("output.txt")
	if err != nil {
		fmt.Println("Error opening output file:", err)
		return
	}
	defer outputFile.Close()

	_, err = outputFile.WriteString(diamondPattern)
	if err != nil {
		fmt.Println("Error writing to output file:", err)
		return
	}

	fmt.Println("Pattern printed to output.txt")
}
