FROM golang:1.8

ENV GOPATH /go
ENV PATH "$GOPATH/bin:$PATH"

RUN go get github.com/leopoldodonnell/clairctl

ENTRYPOINT [ "clairctl" ]
