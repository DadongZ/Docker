package main

import (
    "fmt"
    "os"
    "runtime"
)
func main() {
    hostname, _ := os.Hostname()
    fmt.Printf("I am %s hosting release party on %s/%s \n", hostname, runtime.GOOS, runtime.GOARCH)
}
