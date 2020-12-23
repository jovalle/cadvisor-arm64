FROM arm64v8/golang as builder

LABEL maintainer="Jay Ovalle <jay.ovalle@gmail.com>"

ENV CADVISOR_VERSION "v0.38.6"

RUN git clone --branch ${CADVISOR_VERSION} https://github.com/google/cadvisor.git /go/src/github.com/google/cadvisor

WORKDIR /go/src/github.com/google/cadvisor

RUN make build

FROM arm64v8/debian

LABEL maintainer="Jay Ovalle <jay.ovalle@gmail.com>"

COPY --from=builder /go/src/github.com/google/cadvisor/cadvisor /usr/bin/cadvisor

EXPOSE 8080

ENTRYPOINT ["/usr/bin/cadvisor", "-logtostderr"]
