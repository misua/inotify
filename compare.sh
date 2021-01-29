#!/bin/bash

export ds="/var/log"
file1="$ds/backup_current_users"
file2="$ds/current_users"

hash_it() {
        cut -d : -f 1,6 /etc/passwd | tee -a $ds/results.txt | md5sum | cut -d' ' -f1 > $ds/backup_current_users
}

appendcontent() {
        cat $ds/backup_current_users | tee -a $ds/current_users | echo "`date`" >> $ds/current_users
}


hash_it

if [[ ! -e $ds/current_users ]]; then
	touch $ds/results.txt $ds/backup_current_users $ds/current_users
elif cmp -s "$file1" "$file2"; then
        printf "same files, no changes\n\n"
else
        appendcontent
fi

