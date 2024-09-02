package main

import (
	"fmt"
)

func printDiamond(n int) {
	for i := 0; i < n; i++ {
		for j := 0; j < (n - i - 1); j++ {
			fmt.Print(" ")
		}
		for j := 0; j < (2*i + 1); j++ {
			fmt.Print("*")
		}
		fmt.Println()
	}

	for i := n - 2; i >= 0; i-- {
		for j := 0; j < (n - i - 1); j++ {
			fmt.Print(" ")
		}
		for j := 0; j < (2*i + 1); j++ {
			fmt.Print("*")
		}
		fmt.Println()
	}
}

func main() {
	var n int
	fmt.Print("Enter a number: ")
	fmt.Scan(&n)

	printDiamond(n)
}
