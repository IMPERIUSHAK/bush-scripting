#!/bin/bash

user="$1"

declare -a datakey=("Username" "Password" "UserId" "GroupId" "User Info" "Home directory" "Comand/Shell")

userstring=$(cat /etc/passwd | grep -E "^${user}:")

if [ -z "$userstring" ]; then

	echo -e "\033[1;33mNo user with $user name was found!\033[0m"
	exit 0; 

fi

IFS=':' read -a data <<< "$userstring"

for val in "${!data[@]}"; do

	echo -e "\033[1;34m${datakey[$val]}\033[0m: ${data[$val]}"

done
