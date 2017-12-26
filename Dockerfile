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

# Create app directory
RUN mkdir -p /app
WORKDIR /app