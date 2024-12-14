# include test make file
#include  tests/arduino-core-tests/Makefile



FQBN   ?=
TARGET ?=
UNITY_PATH ?=


# clean-all:
#  clean
# 	-rm -rf cppcheck-reports cppcheck-errors.xml



##############################################################################################################################################################





##############################################################################################################################################################

run-build-target:
	echo "run-build-target : $(FQBN) Unity $(TARGET) -> running workaround.sh ..."
# exampleFlow/bin/workaround.sh $(FQBN) Unity $(TARGET)
	(cd tests/arduino-core-tests ; make FQBN=$(FQBN) UNITY_PATH=Unity $(TARGET))
	echo "run-build-target : $(FQBN) Unity $(TARGET) -> running workaround.sh done."


run-build-target-all:
	make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity TARGET=test_wire_connected1_pingpong       run-build-target
	make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity TARGET=test_wire_connected2_slavepingpong  run-build-target
	make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity TARGET=test_wire_connected2_masterpingpong run-build-target


run-build-all:
	cd tests/arduino-core-tests ; make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity test_wire_connected1_pingpong
	cd tests/arduino-core-tests ; make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity test_wire_connected2_slavepingpong
	cd tests/arduino-core-tests ; make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity test_wire_connected2_masterpingpong


##############################################################################################################################################################


TAG=push

DOCKER=dockerregistry-v2.vih.infineon.com/ifxmakers/makers-docker:$(TAG)
GHCR=ghcr.io/infineon/makers-docker:$(TAG)

REGISTRY=$(DOCKER)

# containerized actions
pull-container:
	docker pull $(REGISTRY)


run-container-build-all: pull-container
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw $(REGISTRY) make run-build-target-all


run-container-check-wire: pull-container
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw $(REGISTRY) exampleFlow/bin/run_cppcheck.sh tests/arduino-core-tests/src/corelibs/wire
	firefox exampleFlow/results/cppcheck/cppcheck-reports/index.html


run-project-setup-script: pull-container
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw $(REGISTRY) python3 exampleFlow/runProjectSetup.py
# firefox exampleFlow/results/cppcheck/cppcheck-reports/index.html


run-project-workflow: pull-container
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw $(REGISTRY) exampleFlow/bin/build.sh --getBuildJobs
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw $(REGISTRY) exampleFlow/bin/build.sh --runBuildJob build-wire-XMC4700
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw $(REGISTRY) exampleFlow/bin/build.sh --runBuildJob check-clang-tidy-wire
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw $(REGISTRY) exampleFlow/bin/build.sh --runBuildJob check-cppcheck-wire
	firefox exampleFlow/results/cppcheck/cppcheck-reports/index.html

##############################################################################################################################################################

# check container content
run-container-bash:
	echo "REGISTRY : " $(REGISTRY)
	docker pull $(REGISTRY)
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw $(REGISTRY) 

# check container content
run-container-check:
	echo "REGISTRY : " $(REGISTRY)
	docker pull $(REGISTRY)
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw $(REGISTRY) exampleFlow/bin/print_tool_versions.sh


# run stuff with container from docker hub
run-container-docker:
	echo "REGISTRY : " $(REGISTRY)
	docker pull $(REGISTRY)
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw $(REGISTRY) exampleFlow/bin/build.sh --runBuildJob build-wire-XMC4700
	docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw $(REGISTRY) make run-build-all
