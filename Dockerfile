FROM golang:1.20.1-alpine AS builder

WORKDIR /src
COPY . .

RUN apk add --no-cache git && \
    go mod download && \
    CGO_ENABLED=0 go build -ldflags="-s -w" -o "wgcf"

FROM alpine:3.17.2

WORKDIR /

COPY --from=builder "/src/wgcf" "/"

ENTRYPOINT ["/wgcf"]
