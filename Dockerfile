FROM keymetrics/pm2:latest

# to make npm test and other automated routines run non-interactively
ENV CI=true

# Update package registry
RUN apk update && apk upgrade

# Install bash, git and openSSH
RUN apk add --no-cache bash git openssh

# Install alpine-SDK (for node-gyp)
RUN apk add --no-cache alpine-sdk

# Install pm2
RUN npm install pm2 -g

# Install python 2 (for node-gyp)
RUN apk add --no-cache python && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools && \
    rm -r /root/.cache

# Create app directory
RUN mkdir -p /app
WORKDIR /app

# Add known hosts
RUN mkdir -p /root/.ssh && touch /root/.ssh/known_hosts && \
    ssh-keyscan -H github.com >> /root/.ssh/known_hosts && \
    ssh-keyscan -H bitbucket.org >> /root/.ssh/known_hosts && \
    cat /root/.ssh/known_hosts