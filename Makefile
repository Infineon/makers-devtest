# include test make file
#include  tests/arduino-core-tests/Makefile



FQBN   ?=
PORT   ?=
TARGET ?=
UNITY_PATH ?= Unity


##############################################################################################################################################################

clean-results:
	-rm -rf exampleFlow/results/cppcheck/*  exampleFlow/results/clang-tidy/* exampleFlow/results/build/*
	- mkdir -p exampleFlow/results/cppcheck exampleFlow/results/clang-tidy exampleFlow/results/build



##############################################################################################################################################################

run-build-target:
	(cd extras/arduino-xensiv-3d-magnetic-sensor-tlx493d ; make -f Makefile.arduino.mk FQBN=$(FQBN) PORT=$(PORT) UNITY_PATH=../arduino-core-tests/Unity $(TARGET))
	# (cd extras/arduino-core-tests ; make FQBN=$(FQBN) UNITY_PATH=Unity $(TARGET))


##############################################################################################################################################################


run-build-target-all:
	make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity TARGET=test_wire_connected1_pingpong       run-build-target
	make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity TARGET=test_wire_connected2_slavepingpong  run-build-target
	make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity TARGET=test_wire_connected2_masterpingpong run-build-target


run-build-all:
	cd tests/arduino-core-tests ; make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity test_wire_connected1_pingpong
	cd tests/arduino-core-tests ; make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity test_wire_connected2_slavepingpong
	cd tests/arduino-core-tests ; make FQBN=Infineon:xmc:XMC4700_Relax_Kit UNITY_PATH=Unity test_wire_connected2_masterpingpong


run-build-command-extras: pull-container
	$(DOCKER) python3 extras/makers-devops/tools/code_checks/codeChecks.py --projectYAML config/project.yml --userYAML config/user.yml --runCheck build-magnetic-w2b6
	$(DOCKER) python3 extras/makers-devops/tools/code_checks/codeChecks.py --projectYAML config/project.yml --userYAML config/user.yml --runCheck check-clang-tidy
	$(DOCKER) python3 extras/makers-devops/tools/code_checks/codeChecks.py --projectYAML config/project.yml --userYAML config/user.yml --runCheck example-magnetic-w2b6-xmc100_xmc2go
	$(DOCKER) python3 extras/makers-devops/tools/code_checks/codeChecks.py --projectYAML config/project.yml --userYAML config/user.yml --runCheck monitor-magnetic-w2b6-xmc100_xmc2go


# run-build-command-tools: pull-container
# 	$(DOCKER) python3 tools/code_checks/codeChecks.py --projectYAML config/project.yml --userYAML config/user.yml --runCheck build-magnetic-w2b6
# 	$(DOCKER) python3 tools/code_checks/codeChecks.py --projectYAML config/project.yml --userYAML config/user.yml --runCheck check-clang-tidy
# 	$(DOCKER) python3 tools/code_checks/codeChecks.py --projectYAML config/project.yml --userYAML config/user.yml --runCheck example-magnetic-w2b6-xmc100_xmc2go
# 	$(DOCKER) python3 tools/code_checks/codeChecks.py --projectYAML config/project.yml --userYAML config/user.yml --runCheck monitor-magnetic-w2b6-xmc100_xmc2go


##############################################################################################################################################################


#TAG=push
# TAG=latest
TAG=test

DOCKER_REGISTRY=dockerregistry-v2.vih.infineon.com/ifxmakers/makers-docker:$(TAG)
GHCR_REGISTRY=ghcr.io/infineon/makers-docker:$(TAG)

REGISTRY=$(DOCKER_REGISTRY)
# REGISTRY=$(GHCR_REGISTRY)

DOCKER=docker run --rm -it -v $(PWD):/myLocalWorkingDir:rw $(REGISTRY)
#DOCKER=

# Lab-PC :
# docker run --rm -it -v .:/myLocalWorkingDir:rw -v /opt:/opt:rw -w /myLocalWorkingDir --device=/dev/ttyACM0 --device=/dev/ttyACM1 --device=/dev/ttyACM2 ifxmakers/makers-docker:push

# wsl
# docker run --rm -it -v .:/myLocalWorkingDir:rw -v /opt:/opt:rw -w /myLocalWorkingDir ifxmakers/makers-docker:push

### Setting DOCKER variable to empty string => containers not used
### Setting DOCKER variable to "docker run ..." => containers used


pull-container:
	docker pull $(REGISTRY)


run-container-build-all: clean-results pull-container
	$(DOCKER) make run-build-target-all


run-container-check-wire: clean-results pull-container
	$(DOCKER) exampleFlow/bin/run_cppcheck.sh exampleFlow/src/cpp/* tests/arduino-core-tests/src/corelibs/wire
	firefox exampleFlow/results/cppcheck/cppcheck-reports/index.html


run-container-project-setup-script: clean-results pull-container
	$(DOCKER) python3 exampleFlow/bin/codeChecks.py --getAllChecks
	$(DOCKER) python3 exampleFlow/bin/codeChecks.py --runCheck check-clang-tidy-wire
	$(DOCKER) python3 exampleFlow/bin/codeChecks.py --runAllChecks
#	firefox exampleFlow/results/cppcheck/cppcheck-reports/index.html


run-container-project-setup-script-with-show-logs: clean-results pull-container
	$(DOCKER) python3 exampleFlow/bin/codeChecks.py --getAllChecks
	$(DOCKER) python3 exampleFlow/bin/codeChecks.py --runCheck check-clang-tidy-wire --showLog
	$(DOCKER) python3 exampleFlow/bin/codeChecks.py --runAllChecks --showLog
#	firefox exampleFlow/results/cppcheck/cppcheck-reports/index.html


run-container-cppcheck: clean-results pull-container
	$(DOCKER) python3 extras/makers-devops/tools/code_checks/codeChecks.py --projectYAML config/project.yml --userYAML config/user.yml --runCheck check-cppcheck
	firefox exampleFlow/results/cppcheck/cppcheck-reports/index.html


run-container-clang-tidy: clean-results pull-container
	$(DOCKER) python3 extras/makers-devops/tools/code_checks/codeChecks.py --projectYAML config/project.yml --userYAML config/user.yml --runCheck check-clang-tidy

##############################################################################################################################################################

# check container content
run-container-bash: pull-container
	$(DOCKER) 


# run stuff with container from docker hub
run-container-build: clean-results pull-container
	$(DOCKER) make run-build-all




