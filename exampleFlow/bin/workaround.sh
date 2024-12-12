#!/bin/sh

cd tests/arduino-core-tests
echo "make FQBN=$1 UNITY_PATH=$2 TARGET=$3
"
make FQBN=$1 UNITY_PATH=$2 $3
