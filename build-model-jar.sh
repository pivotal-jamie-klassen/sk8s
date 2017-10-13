#!/bin/bash

if [ -z "$GOPATH" ]; then
  export GOPATH=$HOME/go
fi

cd $GOPATH
git clone https://github.com/ericbottard/kubernetes-model \
  src/github.com/fabric8io/kubernetes-model/
cd src/github.com/fabric8io/kubernetes-model/
git checkout sk8s-sidecar
make

