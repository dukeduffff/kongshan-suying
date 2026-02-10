#!/bin/bash

mkdir -p build/
mkdir -p build/light
mkdir -p build/dark

cp -r README.md ./jsonnet demo.png build/

cd build/
jsonnet -S -m . --tla-code debug=true ./jsonnet/main.jsonnet

mkdir -p 空山素影
mv * 空山素影/
zip -r kongshan_suying_v8.3.cskin 空山素影
rm -rf 空山素影/

