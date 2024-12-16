#!/bin/sh

#
# build.sh
#


# echo "executing $0 $* ..."


usage() {
  echo "Usage: $0 :" 1>&2;
  echo "          [-g | --getBuildJobs]  [-r | --runBuildJob] <build job>" 1>&2;
  exit 1;
}


# This requires GNU getopt.
TEMP=`getopt -o gr: --long getBuildJobs,runBuildJob:, -n "$0" -- "$@"`

if [ $? != 0 ] ; then
  echo "Terminating..." >&2 ;
  usage ;
  exit 1 ;
fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$TEMP"


getBuildJobs=
runBuildJob=


while true; do
  case "$1" in
    -g | --getBuildJobs )      getBuildJobs="$2";       shift ;;
    -r | --runBuildJob )       runBuildJob="$2";        shift 2 ;;
    -- )                                                shift; break ;;
    * )                    echo "Unknown option '$1' found !" ; usage ; break ;;
  esac
done


if [ -z "${getBuildJobs}" ] && [ -z "${runBuildJob}" ]; then
  usage
fi


if [ ! -z "${getBuildJobs}" ]; then
  # echo "shell : getBuildJobs : ${getBuildJobs}"
  python3 exampleFlow/bin/build.py --getBuildJobs ${getBuildJobs}
  ret=$?
fi


if [ ! -z "${runBuildJob}" ]; then
  # echo "shell : runBuildJob  : ${runBuildJob}"
  python3 exampleFlow/bin/build.py --runBuildJob ${runBuildJob}
  ret=$?
fi


# echo "$0 done."

exit $ret


# python3 bin/build.py --runBuildJob aa
# ret=$?
# echo $ret
