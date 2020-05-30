FROM node:12-alpine
ENV VERCEL_VERSION 19.0.1

LABEL in.kalkani.vercel_version=${VERCEL_VERSION}

RUN apk add --no-cache make
RUN npm install -g vercel@${VERCEL_VERSION}

CMD ["vercel", "--help"]
