  
#!/bin/bash

if [[ (-z "$1") || (-z "$2") ]]
then
	echo "Incorrect args"
else
	if [[ "$1" == "check" ]]
	then
		(find ~/lab4/.as_git -type d 2> /dev/null > /dev/null) || (mkdir ~/lab4/.as_git)
		find ~/lab4/.as_git/$2 -type f 2> /dev/null > /dev/null

		if [[ $? == "0" ]]
		then
			str=$(diff $2 ~/lab4/.as_git/$2)

			if [[ -z $str ]]
			then
				echo $str >> "$2"".log"
			fi
		else
			cp $2 ~/lab4/.as_git/$2
		fi
	else
		if [[ "$1" == "recover" ]]
	     	then
			(find ~/lab4/.as_git -type d 2> /dev/null > /dev/null)

			if [[ $? == "1" ]]
			then
				echo "error"
				exit 1
			fi

			find ~/lab4/.as_git/$2 -type f 2> /dev/null > /dev/null
			

			if [[ $? == "1" ]]
			then
				echo "error 1"
				exit 1
			else
				rm $2
				ln ~/lab4/.as_git/$2 "$2"".lnk"
			fi
		else
			echo "Incorrect command"
		fi
	fi
fi
