#!/bin/sh

# for each user in users.txt
cat /etc/sftp/users.txt | while read -r line || [ -n "$line" ]
do
    # get user,pwd, uid and gid from users.txt
    usr=$(echo $line | cut -d ":" -f 1)
    pwd=$(echo $line | cut -d ":" -f 2)
    uid=$(echo $line | cut -d ":" -f 3)
    gid=$(echo $line | cut -d ":" -f 4)

    # chown user homedir and storage folder
    chown -R $uid:$gid /home/$usr/* && chown -R $usr /home/$usr/* 
    echo "Fixed permissions for user $usr with uid $uid and gid $gid."
done

