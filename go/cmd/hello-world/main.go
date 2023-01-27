package main

import (
	"fmt"
	"hello-world/internal/greet"
)

func main() {
	fmt.Println(greet.FormatGreeting("Dog Person")) //nolint:forbidigo // Cli Response
}
