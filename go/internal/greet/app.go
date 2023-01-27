package greet

import (
	"fmt"
)

func FormatGreeting(name string) string {
	return fmt.Sprintf("Hello %s!", name)
}
