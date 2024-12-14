#!/bin/sh

cd tests/arduino-core-tests
echo "make FQBN=$1 UNITY_PATH=$2 $3"

arduino-cli core install Infineon:xmc

make FQBN=$1 UNITY_PATH=$2 $3
