#!/usr/bin/env bash
T=$1
launch() { xfce4-terminal --title "$1" --command "bash -c '$2; read'" & }
 
launch "feroxbuster" "feroxbuster --url $T --wordlist /usr/share/seclists/Discovery/Web-Content/common.txt"
launch "gobuster"    "gobuster dir --url $T --wordlist /usr/share/seclists/Discovery/Web-Content/raft-medium-directories.txt"
launch "ffuf"        "ffuf -u $T/FUZZ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
launch "dirb"        "dirb $T /usr/share/wordlists/rockyou.txt"
 