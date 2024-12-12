#!/bin/sh

# --suppress=misra* --suppress=duplicateBreak

cppcheck --error-exitcode=1 --check-level=exhaustive --enable=all --inconclusive \
         --addon=./config/cppcheck/misra.json --addon=misc --std=c++20 \
         --suppress=missingIncludeSystem \
         --max-configs=50 --xml 2> exampleFlow/results/cppcheck/cppcheck-errors.xml $*
ret=$?

cppcheck --version
which cppcheck
which cppcheck-htmlreport

cppcheck-htmlreport --file=exampleFlow/results/cppcheck/cppcheck-errors.xml --title=TestCPPCheck --report-dir=exampleFlow/results/cppcheck/cppcheck-reports --source-dir=.
# mv cppcheck-errors.xml cppcheck-reports
# mv cppcheck-addon-ctu* exampleFlow/results/cppcheck/

chown -R --reference=tests exampleFlow/results/cppcheck/*
# chown -R --reference=tests cppcheck-reports

echo "$0 done."

#exit $ret
exit 0
