FROM filebrowser/filebrowser:v2

# install su-exec to switch user in runtime
RUN apk --no-cache add su-exec

# copy the fileserver config
COPY filebrowser.json /.filebrowser.json

# copy start script
COPY start.sh /start.sh

# fix the permissions
RUN chmod +x /start.sh

# copy empty database 
COPY database-init.db /database-init.db

ENTRYPOINT [ "/start.sh" ]