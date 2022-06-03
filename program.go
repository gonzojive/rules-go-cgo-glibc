package main

import (
	"fmt"

	"github.com/gonzojive/rules-go-cgo-glibc/sub"
)

func main() {
	fmt.Printf("floored: %f\n", sub.Floor(60))
}
