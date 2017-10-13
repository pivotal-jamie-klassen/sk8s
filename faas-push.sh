#!/bin/bash
set -e

build_root=$(dirname $0)

function_file=$1
function_name=$2

echo "building function ${function_name} from file ${function_file}"
$build_root/faas-build.sh $function_file $function_name

topic_name=${function_name}-input
echo "creating topic ${topic_name}..."
kubectl create -f <(cat <<EOF
apiVersion: extensions.sk8s.io/v1
kind: Topic
metadata:
  name: ${topic_name}
EOF)

echo "deploying function ${function_name}"
kubectl create -f <(cat <<EOF
apiVersion: extensions.sk8s.io/v1
kind: Function
metadata:
  name: $function_name
spec:
  input: $topic_name
  protocol: stdio
  image: $function_name
  command: ["node", "/invoker.js", "/${function_name}.js"]
EOF)
