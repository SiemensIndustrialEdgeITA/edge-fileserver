#### Stage BASE ########################################################
FROM node:14-alpine AS BASE

# Install base os packages
RUN set -ex && \
    apk add --no-cache \
        bash \
        tzdata \
        iputils \
        linux-headers \
        udev \
        openssl

# Copy app package for installing libs
WORKDIR /usr/src/app/
COPY ./app/package.json ./package.json

#### Stage BUILD #######################################################
FROM BASE AS BUILD

# Install build os packages
RUN apk add --no-cache --virtual buildtools \
                        ca-certificates \
                        curl \
                        openssh-client \
                        build-base 

# Install App Packages
WORKDIR /usr/src/app/
RUN npm install

# Generate HTTPS certs
WORKDIR /tmp/certs
RUN openssl req -new -newkey rsa:4096 -days 9999 -nodes -x509 \
    -subj "/C=IT/ST=Milan/L=Milan/O=Siemens/CN=example-webserver-app-fileserver" \
    -keyout server.key -out server.cert

#### Stage RELEASE #######################################################################################################
FROM BASE AS RELEASE

RUN export BUILD_DATE=$(date +"%Y-%m-%dT%H:%M:%SZ")

WORKDIR /usr/src/app/
# copy builded modules from BUILD
COPY --from=BUILD /usr/src/app/node_modules ./node_modules
# copy generated certs from BUILD
COPY --from=BUILD /tmp/certs ./certs
# copy all the app source code
COPY ./app/ ./

# create a folder for configuration files
RUN mkdir -p /opt/app/config

# this cmd will be replaced from the docker-compose command parameter
CMD ["node", "/usr/src/app/main.js"]

#CMD ["tail","-f","/dev/null"]