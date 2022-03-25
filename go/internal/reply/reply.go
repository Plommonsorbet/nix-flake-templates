package reply

import (
	"fmt"
	"log"
	"github.com/google/uuid"
)

func SayHelloWorld() {
	fmt.Println("Hello world!")
}

func SayRandomUUID() {

	 id, err := uuid.NewRandom()
	 if err != nil {
	 	log.Fatalf("ERROR: %s", err.Error())
	 } else {
	   fmt.Printf("UUID: %s", id)
	 }

}
