#!/bin/sh

hash

echo "Environment variables :"
echo "    ARDUINO_CLI_VERSION  : ${ARDUINO_CLI_VERSION}"
echo "    XMC4ARDUINO_VERSION  : ${XMC4ARDUINO_VERSION}"
echo "    PSOC4ARDUINO_VERSION : ${PSOC4ARDUINO_VERSION}"
echo ""
echo "    CPPCHECK_VERSION     : ${PSOC4ARDUINO_VERSION}"
echo "    LLVM_VERSION         : ${PSOC4ARDUINO_VERSION}"
echo ""
echo "    BRANCH               : ${BRANCH}"
echo ""
echo "    ARDUINO_CONFIG_FILE      : ${ARDUINO_CONFIG_FILE}"
echo "    ARDUINO_DIRECTORIES_DATA : ${ARDUINO_DIRECTORIES_DATA}"
echo ""

echo "Tools :"
echo "    which arduino-cli : "`which arduino-cli`
echo ""

echo "    clang --version : "`clang --version`
echo ""

echo "    clang-format --version : "`clang-format --version`
echo ""

echo "    clang-tidy --version : "`clang-tidy --version`
echo ""

echo "    gcc --version : "`gcc --version`
echo ""

echo "    cppcheck --version : "`cppcheck --version`
echo ""

echo "    which scanbuild : "`which scanbuild`
echo ""


arduino-cli board listall Infineon:xmc

ls -lR ~/.arduino15/packages/Infineon/hardware/xmc/3.4.1

grep -ri github /root/.arduino15