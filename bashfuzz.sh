#!/usr/bin/env bash
T=$1
export XDG_RUNTIME_DIR=/tmp/runtime-root
PIDS=()
launch() { qterminal --title "$1" -e "bash -c '$2; read'" & PIDS+=($!); }
 
launch "feroxbuster" "feroxbuster --url $T --wordlist /home/kali/seclists/Discovery/Web-Content/common.txt --filter-status 502,503,429"
launch "gobuster"    "gobuster dir --url $T --wordlist /home/kali/seclists/Discovery/Web-Content/raft-medium-directories.txt -b 404,502,503,429"
launch "ffuf"        "ffuf -u $T/FUZZ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -mc 200,301,302,403 -fc 502,503,429 -s"
 
zenity --warning --title="Fuzzer Control" --text="Fuzzers running...\nClick OK to kill all." --ok-label="Kill All"
kill "${PIDS[@]}" 2>/dev/null
