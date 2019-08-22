FROM node:8-alpine

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL maintainer="roalcantara <rogerio.alcantara@gmail.com>" \
  org.opencontainers.image.title="Node 8, Yarn and Firebase Admin, Functions and Tools" \
  org.opencontainers.image.description="Lightweight Docker image based on NodeJS 8 with Yarn and Firebase Admin, Functions and Tools." \
  org.opencontainers.image.authors="roalcantara <rogerio.alcantara@gmail.com>" \
  org.opencontainers.image.documentation="https://github.com/roalcantara/node-yarn-firebase/README.md" \
  org.opencontainers.image.url="https://github.com/roalcantara/node-yarn-firebase" \
  org.opencontainers.image.source="https://github.com/roalcantara/node-yarn-firebase.git" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$VCS_REF \
  org.opencontainers.image.created=$BUILD_DATE

# Commands
RUN \
  apk update \
  && apk upgrade \
  && apk add --no-cache git yarn
RUN \
  yarn global add firebase-admin firebase-functions firebase-tools
