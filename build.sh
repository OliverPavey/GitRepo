#!/bin/bash

mkdir -p build/windows/amd64
mkdir -p build/linux/amd64

GOOS=windows GARCH=amd64 go build -o build/windows/amd64/gitrepo.exe gitrepo.go
GOOS=linux   GARCH=amd64 go build -o build/linux/amd64/gitrepo       gitrepo.go