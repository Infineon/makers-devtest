# include test make file
#include  tests/arduino-core-tests/Makefile



FQBN   ?=
TARGET ?=


# clean-all:
#  clean
# 	-rm -rf cppcheck-reports cppcheck-errors.xml



##############################################################################################################################################################




#  35afbf0d7a07773fef35898551eb343cbf1859a1

##############################################################################################################################################################

run-build-target:
	cd tests/arduino-core-tests ; make FQBN=$(FQBN) UNITY_PATH=Unity $(TARGET)


run-build-all:
	cd tests/arduino-core-tests ; make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity test_wire_connected1_pingpong
	cd tests/arduino-core-tests ; make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity test_wire_connected2_slavepingpong
	cd tests/arduino-core-tests ; make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity test_wire_connected2_masterpingpong



# containerized actions
pull-container:
	docker pull ghcr.io/infineon/makers-docker:latest


run-container-build-all: pull-container
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw ghcr.io/infineon/makers-docker:latest make run-build-all


run-container-check-wire: pull-container
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw ghcr.io/infineon/makers-docker:latest exampleFlow/bin/run_cppcheck.sh tests/arduino-core-tests/src/corelibs/wire
	firefox exampleFlow/results/cppcheck/cppcheck-reports/index.html


run-project-setup-script: pull-container
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw ghcr.io/infineon/makers-docker:latest python3 exampleFlow/runProjectSetup.py
# firefox exampleFlow/results/cppcheck/cppcheck-reports/index.html


run-project-workflow: pull-container
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw ghcr.io/infineon/makers-docker:latest exampleFlow/bin/build.sh --getBuildJobs


##############################################################################################################################################################

# check container content
run-container-bash:
	docker pull ghcr.io/infineon/makers-docker:latest
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw ghcr.io/infineon/makers-docker:latest

# check container content
run-container-check:
	docker pull ghcr.io/infineon/makers-docker:latest
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw ghcr.io/infineon/makers-docker:latest exampleFlow/bin/print_tool_versions.sh


# run stuff with container from docker hub
run-container-docker:
	docker pull dockerregistry-v2.vih.infineon.com/ifxmakers/makers-docker:latest
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw dockerregistry-v2.vih.infineon.com/ifxmakers/makers-docker:latest make run-build-all
