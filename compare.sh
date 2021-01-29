#!/bin/bash



hash_it() {
        cut -d : -f 1,6 /etc/passwd | tee -a results.txt | md5sum | cut -d' ' -f1 > backup_current_users
}

appendcontent() {
        cat backup_current_users | tee -a current_users | echo "`date`" >> current_users
}


hash_it


file1="/home/sab/Desktop/gitlab_exam/backup_current_users"
file2="/home/sab/Desktop/gitlab_exam/current_users"

if cmp -s "$file1" "$file2"; then
        printf "same files, no changes\n\n"
else
        appendcontent

fi

