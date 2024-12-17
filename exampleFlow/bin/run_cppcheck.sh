#!/bin/sh


if [ ! -d "$exampleFlow/results/cppcheck" ]; then
  mkdir -p exampleFlow/results/cppcheck
fi


# --suppress=misra* --suppress=duplicateBreak

cppcheck --error-exitcode=1 --check-level=exhaustive --enable=all --inconclusive \
         --addon=./config/cppcheck/misra.json --addon=misc --std=c++20 \
         --suppress=missingIncludeSystem \
         --max-configs=50 --xml 2> exampleFlow/results/cppcheck/cppcheck-errors.xml $*
ret=$?

cppcheck-htmlreport --file=exampleFlow/results/cppcheck/cppcheck-errors.xml --title=TestCPPCheck --report-dir=exampleFlow/results/cppcheck/cppcheck-reports --source-dir=.

chown -R --reference=tests exampleFlow/results/cppcheck/*

echo "$0 done."

#exit $ret
exit 0
