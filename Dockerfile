FROM node:alpine

# to make npm test and other automated routines run non-interactively
ENV CI=true

# Install gyp dependencies
RUN apk add --no-cache --virtual .gyp \
        python \
        make \
        g++ \
    && python -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip install --upgrade pip setuptools \
    && rm -r /root/.cache

# Add known hosts
RUN mkdir -p /root/.ssh && touch /root/.ssh/known_hosts \
    && ssh-keyscan -H github.com >> /root/.ssh/known_hosts \
    && ssh-keyscan -H bitbucket.org >> /root/.ssh/known_hosts \
    && cat /root/.ssh/known_hosts

# Create app directory
RUN mkdir -p /app
WORKDIR /app