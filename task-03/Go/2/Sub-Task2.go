package main

import (
	"fmt"
	"os"
)

func main() {
	inputContent, err := os.ReadFile("input.txt")
	if err != nil {
		fmt.Println("Error reading input file:", err)
		return
	}

	err = os.WriteFile("output.txt", inputContent, 0644)
	if err != nil {
		fmt.Println("Error writing to output file:", err)
		return
	}

	fmt.Println("Content successfully copied to output.txt")
}
