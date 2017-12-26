FROM node:alpine

# to make npm test and other automated routines run non-interactively
ENV CI=true

# Add known hosts
RUN apk add --no-cache openssh \
    && mkdir -p /root/.ssh && touch /root/.ssh/known_hosts \
    && ssh-keyscan -H github.com >> /root/.ssh/known_hosts \
    && ssh-keyscan -H bitbucket.org >> /root/.ssh/known_hosts \
    && cat /root/.ssh/known_hosts \
    && apk del openssh

# Install gyp dependencies
RUN apk add --no-cache python make g++

# Create app directory
RUN mkdir -p /app
WORKDIR /app