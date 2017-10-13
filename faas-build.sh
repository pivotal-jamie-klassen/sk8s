#!/bin/bash

set -e

scriptfile=$1
tagname=$2

dir=$(mktemp -d)
cd $dir

cp $scriptfile script.js

cat > invoker.js <<EOF
var readline = require('readline');
var fs = require('fs');
var path = require('path');

var rl = readline.createInterface({
  input: process.stdin,
  output: new require('stream').Writable()
});

var funcFile = process.argv[process.argv.length - 1];
var code = fs.readFileSync(funcFile, 'utf8');
eval(code);
var func = eval(path.basename(funcFile, path.extname(funcFile)));

rl.on('line', (line) => console.log(func(line)));
EOF

cat > Dockerfile <<EOF
FROM mhart/alpine-node
COPY script.js /$tagname.js
COPY invoker.js /invoker.js
ENTRYPOINT ["node", "/invoker.js", "/$tagname.js"]
EOF

docker build . -t $tagname
