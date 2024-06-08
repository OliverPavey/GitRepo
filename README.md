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

`build.bat` or `.\build.sh`