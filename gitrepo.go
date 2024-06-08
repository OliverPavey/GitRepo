package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"regexp"
	"runtime"
	"strings"
)

func readOrigin() string {
	var command = "git config --get remote.origin.url"
	var command_parts = strings.Split(command, " ")
	output, err := exec.Command(command_parts[0], command_parts[1:]...).Output()
	if err != nil {
		fmt.Println("'gitrepo' needs to be run from a GIT repository.")
		os.Exit(-1)
	}
	return strings.ReplaceAll(string(output), "\n", "")
}

func extractBaseAndRepo(origin string) (string, string) {
	var expected = "^(?:git@|https:\\/\\/)(.*?)(?:[:\\/])(.*?)(?:\\.git)?$"
	reExpected := *regexp.MustCompile(expected)
	result := reExpected.FindAllStringSubmatch(origin, -1)
	if len(result) == 0 {
		return "", ""
	} else {
		return result[0][1], result[0][2]
	}
}

func openInBrowser(url string) {
	var err error

	switch runtime.GOOS {
	case "linux":
		err = exec.Command("xdg-open", url).Start()
	case "windows":
		err = exec.Command("rundll32", "url.dll,FileProtocolHandler", url).Start()
	case "darwin":
		err = exec.Command("open", url).Start()
	default:
		err = fmt.Errorf("unsupported platform")
	}

	if err != nil {
		log.Fatal(err)
	}
}

func main() {
	mode := strings.ToLower(append(os.Args[1:], "")[0])
	origin := readOrigin()
	base, repo := extractBaseAndRepo(origin)

	switch mode {
	case "?":
		fmt.Println("Syntax: gitrepo ssh|s|https|h|web|w|open|o|info|i")
	case "ssh", "s":
		fmt.Printf("git@%s:%s.git\n", base, repo)
	case "https", "h":
		fmt.Printf("https://%s/%s.git\n", base, repo)
	case "web", "w":
		fmt.Printf("https://%s/%s\n", base, repo)
	case "name", "n":
		var sl = strings.Split(repo, "/")
		fmt.Printf("%s\n", sl[len(sl)-1])
	case "open", "o":
		openInBrowser(fmt.Sprintf("https://%s/%s", base, repo))
	default: // includes "info" and "i"
		fmt.Printf("GitSSH  : git@%s:%s.git\n", base, repo)
		fmt.Printf("GitHTTPS: https://%s/%s.git\n", base, repo)
		fmt.Printf("WebPage : https://%s/%s\n", base, repo)
	}
}
