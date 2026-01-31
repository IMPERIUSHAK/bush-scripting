#!/bin/bash


cleanup() {
    echo -e "\033[1:33mUsage[!] CTRL-C detected, stopping scan...\033[0m"
    kill 0
    exit 1
}

trap cleanup INT


IP=$1

dest1=$2
dest2=$3

if [ $# -lt 2 ]; then
	echo "\033[1;33mUsage: $0 <IP> <port1> [port2] --> optional\033[0m"
	exit 1
fi

if [ -z "$dest2" ]; then

	timeout 2 bash -c "echo > /dev/tcp/$IP/$2" 2>/dev/null
	ans=$?

	if [ $ans -eq 0 ]; then
		echo -e "\033[1;34mPort with number ---> $2 is OPEN\033[0m"
	elif [ $ans -eq 1 ]; then
		echo -e "\033[1;31mPort: $2 is CLOSED\033[0m"
	else
		echo -e "\033[1;33mPort: $3 is FILTERED\033[0m"
	fi
else

echo -e "\033[1;33m Checking ports from $2 ----> $3 please wait \033[0m"

THREADS=20

for (( j=$dest1; j<=$dest2; j++ )); do
(
    timeout 2 bash -c "echo > /dev/tcp/$IP/$j" 2>/dev/null
    ans=$?

    if [ $ans -eq 0 ]; then
        echo -e "\033[1;34mPort $j is OPEN\033[0m"
    elif [ $ans -eq 124 ]; then
        echo -e "\033[1;33mPort $j is FILTERED\033[0m"
    fi
) &


    while [ "$(jobs -r | wc -l)" -ge "$THREADS" ]; do
        sleep 0.05
    done
done

wait

fi
