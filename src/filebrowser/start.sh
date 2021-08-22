#!/bin/sh

# if db file is not found, create it by copy the empty db file
DBFILE=/config/database.db
if [ -f "$DBFILE" ]; then
    echo "$DBFILE exists."
else 
    echo "$DBFILE does not exist."
    mkdir -p /config
    cp /database-init.db $DBFILE
    echo "$DBFILE created."
fi

# read actual user
curusr=$(whoami)
curuid=$(id -u)
curgid=$(id -g)
echo "Current user is $curusr with uid $curuid and gid $curgid"

# only for the user on the first line in users.txt
firstusr=$(head -n 1 /config/users.txt)

# get user,pwd, uid and gid from first user
usr=$(echo $firstusr | cut -d ":" -f 1)
pwd=$(echo $firstusr | cut -d ":" -f 2)
uid=$(echo $firstusr | cut -d ":" -f 3)
gid=$(echo $firstusr | cut -d ":" -f 4)

# add user from users.conf like sftp container
addgroup -g $gid $usr
adduser --disabled-password -u $uid -g $gid -G $usr -h /storage -D $usr
#echo "$usr:$pwd" | chpasswd
export HOME=/storage

# chown donfig and storage folder
chown -R $uid:$gid /storage
chown -R $uid:$gid /config && chown -R $uid:$gid /config/database.db
echo "Fixed permissions for user $usr with uid $uid and gid $gid."

# start filebrowser app as new user
echo "Starting File Browser App..."
su-exec $usr:$uid /filebrowser -d /config/database.db