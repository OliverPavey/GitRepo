# GitRepo

Command line utility to report on the repository for the project in the current directory.

Syntax `gitrepo <mode>|<short>`

Mode | Short | Description
--|--|--
ssh | s | Show the SSH reference to the repository
https | h | Show the HTTPS reference to the repository
web | w | Show the Web URL for the repository
info | i | Report all of the above
open | o | Open the web repository web page in a browser

## Build instructions

### To run in development

`go run gitrepo.go`

### To build the executable

`go build gitrepo.go`

### To build the executables for cross platform

From bash (including Git bash on Windows):

`.\build.sh`

Builds the executables for Windows AMD64 and for Linux AMD64 platforms.
