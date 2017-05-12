FROM golang:1.8

ENV GOPATH /go
ENV PATH "$GOPATH/bin:$PATH"

# RUN go get -u github.com/leopoldodonnell/clairctl
COPY . /go/src/github.com/leopoldodonnell/clairctl
WORKDIR /go/src/github.com/leopoldodonnell/clairctl
RUN go install

ENTRYPOINT [ "clairctl" ]
