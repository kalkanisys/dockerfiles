FROM ubuntu:bionic

LABEL in.kalkani.mongodb_version=4.2

RUN apt-get -qq update -y && \
  apt-get -qq install -y wget gnupg jq make gzip && \
  rm -rf /var/lib/apt/lists/*

# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add - && \
  echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | \
  tee /etc/apt/sources.list.d/mongodb-org-4.2.list && \
  apt-get -qq update -y && \
  apt-get -qq install -y mongodb-org-shell mongodb-org-tools && \
  apt-get -qq remove -y --purge gnupg && \
  rm -rf /var/lib/apt/lists/*
