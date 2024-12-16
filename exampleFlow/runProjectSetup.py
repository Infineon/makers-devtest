
# python.exe runProjectSetup.py


import os
import subprocess
import sys
import yaml


importPath = os.path.normpath(
    os.path.dirname(os.path.realpath(os.path.abspath(__file__))) + "/src/python"
)

if not importPath in sys.path:
    sys.path.insert(1, importPath)


from check_schemata.checkProjectYAMLSchema import checkProjectYAMLSchema
from check_schemata.checkUserYAMLSchema import checkUserYAMLSchema


@staticmethod
def readProjectYAML(project, user):
    with open(project, "r") as file:
        projectYAML = yaml.safe_load(file)

    # print(f"projectYAML : {projectYAML}\n")

    with open(user, "r") as file:
        userYAML = yaml.safe_load(file)

    # print(f"userYAML : {userYAML}\n")

    checkProjectYAMLSchema(projectYAML)
    checkUserYAMLSchema(userYAML)

    return (projectYAML, userYAML)


if __name__ == "__main__":

    (projectYAML, userYAML) = readProjectYAML(
        "exampleFlow/project.yml", "exampleFlow/user.yml"
    )

    # print(f"projectYAML : {projectYAML}\n")

    for (checkType, checkTypeList) in userYAML.items():
        # print(f"type : {checkType}")

        if checkType not in projectYAML:
            print(f"ERROR : {checkType} not found in project YAML !")
            exit(1)

        for check in checkTypeList:
            # print(f"    check : {check}")

            if check not in projectYAML[checkType]:
                print(f"ERROR : {check} not found in project YAML for {checkType} !")
                exit(1)

            if checkType == 'build':
                # print(f"        {projectYAML[checkType][check]['target']}  for  FQBN  {projectYAML[checkType][check]['fqbn']}  ...")

                subprocess.run(["make", "run-build-target", f"FQBN={projectYAML[checkType][check]['fqbn']}", f"TARGET={projectYAML[checkType][check]['target']}"])

                # print(f"        {projectYAML[checkType][check]['target']}  for  FQBN  {projectYAML[checkType][check]['fqbn']}  done.\n")
            elif checkType == 'check':
                if 'command' not in projectYAML[checkType][check]:
                    print(f"ERROR : 'command' not found in project YAML for {checkType} / {check} !")
                    exit(1)

                # print(f"        {projectYAML[checkType][check]['command']}  ...")

                # subprocess.run(["clang-tidy", "-header-filter=.", "tests/arduino-core-tests/src/corelibs/wire/test_wire_connected1_pingpong.cpp", "--"])
                with open(f"exampleFlow/results/clang-tidy/{check}.log", "w") as logfile:
                    subprocess.run(projectYAML[checkType][check]['command'].split(), stdout=logfile)

                # print(f"        {projectYAML[checkType][check]['command'].split()}  done.\n")

        # print("\n")


    exit(0)
