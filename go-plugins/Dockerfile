FROM golang:1.16-alpine as builder

RUN apk add --no-cache git gcc libc-dev bash
RUN go install github.com/Kong/go-pluginserver@v0.6.1

ADD entrypoint.sh /entrypoint.sh
RUN mkdir /go-plugins
WORKDIR /go-plugins

ENTRYPOINT ["/entrypoint.sh"]
