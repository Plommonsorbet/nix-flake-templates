package greet_test

import (
	"hello-world/internal/greet"
	"testing"
)

func TestGreet(t *testing.T) {
	greeting := greet.FormatGreeting("Dog Person")
	expected := "Hello Dog Person!"
	if greeting != expected {
		t.Errorf("Not equal: '%s' != '%s'", greeting, expected)
	}
}
