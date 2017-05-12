#!/bin/bash

# The following assume that:
# 1. You've already got clair running
# 2. Clair is running on the same host as clairctl
# 3. You're running on OS X with your host IP found by
#    interface en0
MY_ADDRESS=$(ipconfig getifaddr en0)
MY_ADDRESS='clairctl'
MY_PORT=9279
CLAIR_ADDRESS=$(ipconfig getifaddr en0)
CLAIR_ADDRESS='clair_clair'
CLAIR_PORT=6060

DEBUG="--log-level DEBUG"

# Generate the clairctl yaml file
cat << EOF > clairctl.yml
clairctl:
  ip: $MY_ADDRESS
  bind_addr: 0.0.0.0
  port: 9279
clair:
  port: 6060
  healthPort: 6061
  uri: http://$CLAIR_ADDRESS
  report:
    path: /reports
    format: html
EOF

# Run clairctl in a container. Share the host's docker socket to
# enable docker operations from within the container.
docker run --rm \
  --network clair_default \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $PWD/clairctl.yml:/clairctl.yml \
  -v $PWD/reports:/reports \
  -v $HOME/.docker:/root/.docker \
  -p $MY_PORT:$MY_PORT \
  clairctl --config /clairctl.yml $DEBUG $@
# clairctl  $DEBUG $@
