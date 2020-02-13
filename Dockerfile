FROM golang:latest AS builder
RUN go get -u -v github.com/ncw/rclone

FROM ubuntu:focal
RUN apt-get update && \
	apt-get install -y curl ca-certificates && \
	apt-get clean
COPY --from=builder /go/bin/rclone /usr/local/bin/rclone

