#!/bin/bash

kubectl apply -f config/kafka --validate=false
kubectl apply -f config --validate=false
