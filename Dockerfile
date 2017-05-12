FROM golang:1.8

ENV GOPATH /go
ENV PATH "$GOPATH/bin:$PATH"

# RUN go get -u github.com/leopoldodonnell/clairctl
COPY . /go/src/github.com/leopoldodonnell/clairctl
WORKDIR /go/src/github.com/leopoldodonnell/clairctl
RUN go install


# install docker since its needed by the app
# ARG DOCKER_VERSION="1.11.1"
#
# RUN curl -L -o docker-${DOCKER_VERSION}.tgz https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz && \
#     tar xf docker-${DOCKER_VERSION}.tgz && \
#     find docker -exec cp {} /usr/bin \; && \
#     rm -rf docker docker-${DOCKER_VERSION}.tgz

ENTRYPOINT [ "clairctl" ]
