FROM --platform=$BUILDPLATFORM golang:1.15 AS build
LABEL maintainer="Jay Ovalle <jay.ovalle@gmail.com>"
ARG TARGETARCH
ENV GOARCH=$TARGETARCH
RUN go get github.com/google/cadvisor && \
  cd /go/src/github.com/google/cadvisor && \
  make build
  
FROM debian
LABEL maintainer="Jay Ovalle <jay.ovalle@gmail.com>"
COPY --from=build /go/src/github.com/google/cadvisor/cadvisor /usr/bin/cadvisor
EXPOSE 8080
ENTRYPOINT ["/usr/bin/cadvisor", "-logtostderr"]