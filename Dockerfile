FROM golang:latest AS builder
RUN go get -u -v github.com/ncw/rclone

FROM ubuntu:bionic
RUN apt-get update && \
	apt-get install -y curl ca-certificates && \
	apt-get clean
COPY --from=builder /go/bin/rclone /usr/local/bin/rclone
RUN curl -sSLo jobber.deb https://github.com/dshearer/jobber/releases/download/v1.3.2/jobber_1.3.2-1_amd64_ubuntu16.deb && \
	dpkg -i jobber.deb && \
	rm -f jobber.deb

# Run the scheduler
CMD ["/usr/libexec/jobbermaster"]

