#!/bin/bash

cleanup() {

  echo -e "\033[1;33mUsage[!] CTRL-C detected, stopping scan ... \033[0m"
  kill 0
  exit 1

}

trap cleanup INT

url=""
wordls=""

if [[ $# -ne 4 ]]; then
    echo -e "\033[1;31m[!] Incorrect number of arguments\033[0m"
    echo -e "\033[1;33mUsage: $0 -w [wordlist] -u [URL]\033[0m"
    exit 1
fi

if [[ "$1" == "-u" ]] && [[ "$3" == "-w"  ]]; then
	url="$2"
	wordls="$4"
elif [[ "$1" == "-w" ]] && [[ "$3" == "-u" ]]; 
then
	url="$4"
	wordls="$2"

else
	echo -e "\033[1;33m Incorrect usage of script:\n httpffuz -w [wordlist] -u [Url]\033[0m"
	exit 0
fi


echo -e "Url: $url\nWordlist: $wordls"

