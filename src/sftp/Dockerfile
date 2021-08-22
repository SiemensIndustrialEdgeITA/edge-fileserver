FROM atmoz/sftp:alpine

# copy set permission script
COPY set-permissions.sh /etc/sftp.d/set-permissions.sh

# copy edited entrypoint for users.txt
COPY entrypoint /entrypoint

# fix the permissions
RUN chmod +x /etc/sftp.d/set-permissions.sh && chmod +x /entrypoint

ENTRYPOINT [ "/entrypoint" ]