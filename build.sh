#!/bin/bash
build_root=$(dirname $0)

eval "$(minikube docker-env)"
$build_root/mvnw clean package
$build_root/dockerize
