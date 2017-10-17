#!/bin/bash

set -euo pipefail

build_root=$PWD
model_dir="$(go env GOPATH)/src/github.com/fabric8io"
mkdir -p $model_dir
cp -r $build_root/kubernetes-model $model_dir/kubernetes-model
cd $model_dir/kubernetes-model
make
cd $build_root/sk8s
./mvnw clean test
