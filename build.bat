@ECHO OFF
SETLOCAL

mkdir build               2>nul
mkdir build\windows       2>nul
mkdir build\windows\amd64 2>nul
mkdir build\linux         2>nul
mkdir build\linux\amd64   2>nul

set GOOS=windows
set GARCH=amd64
go build -o build\windows\amd64\gitrepo.exe gitrepo.go

set GOOS=linux
set GARCH=amd64
go build -o build\linux\amd64\gitrepo       gitrepo.go

ENDLOCAL