FROM node:8-alpine

# to make npm test and other automated routines run non-interactively
ENV CI=true

# Update package registry
RUN apk update && apk upgrade

# Install bash, git and openSSH
RUN apk add --no-cache bash git openssh

# Create app directory
RUN mkdir -p /app
WORKDIR /app

# Add known hosts
RUN mkdir -p /root/.ssh && touch /root/.ssh/known_hosts && \
    ssh-keyscan -H github.com >> /root/.ssh/known_hosts && \
    ssh-keyscan -H bitbucket.org >> /root/.ssh/known_hosts && \
    cat /root/.ssh/known_hosts