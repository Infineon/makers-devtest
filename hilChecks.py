#!/usr/bin/python3

# python3 hilChecks.py

import argparse
import os
import subprocess
import sys

tools_path = os.path.dirname(os.path.abspath(__file__))
# sys.path.insert(1, tools_path + "/..")
# sys.path.insert(1, tools_path + "/extras/makers-devops/tools")

#from project_yaml.readProjectYAML import readProjectYAML


def parseArgs():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--getAllChecks", action="store_true", help="Get all checks help"
    )
    parser.add_argument(
        "--runAllChecks", action="store_true", help="Run all checks help"
    )
    parser.add_argument("--runCheck", type=str, help="Run a specific check help")
    parser.add_argument(
        "--projectYAML", type=str, required=True, help="Path to the project YAML file"
    )
    parser.add_argument(
        "--userYAML", type=str, required=True, help="Path to the user YAML file"
    )

    args = parser.parse_args()

    return args


def runCheck(projectYAML, checkType=None, check=None):
    returnCode = 0

    if checkType is None:
        print(f"ERROR : Check type 'None' is not valid !")
        returnCode = 1

    elif check is None:
        print(f"ERROR : Check 'None' is not valid !")
        returnCode = 1

    elif checkType == "build":
        returnCode |= subprocess.run(
            [
                "make",
                "run-build-target",
                f"FQBN={projectYAML[checkType][check]['fqbn']}",
                f"TARGET={projectYAML[checkType][check]['target']}",
            ]
        ).returncode

    elif checkType == "check":
        if "command" not in projectYAML[checkType][check]:
            print(
                f"ERROR : Option 'command' not found in project YAML for {checkType} / {check} !"
            )
            returnCode = 1

        else:
            paramList = projectYAML[checkType][check]["command"].split()
            paramList.insert(1, f"--file-prefix={check}")
            returnCode |= subprocess.run(paramList).returncode
    # elif checkType == "hil":
    #     if "command" not in projectYAML[checkType][check]:
    #         print(
    #             f"ERROR : Option 'command' not found in project YAML for {checkType} / {check} !"
    #         )
    #         returnCode = 1

    #     else:
    #         paramList = projectYAML[checkType][check]["command"].split()
    #         paramList.insert(1, f"--file-prefix={check}")
    #         returnCode |= subprocess.run(paramList).returncode

    if returnCode == 2:
        print(f"ERROR : Running check '{check}' failed due to failed code checks !")
    elif returnCode != 0:
        print(f"ERROR : Problem running check '{check}' !")

    return returnCode


if __name__ == "__main__":
    print("\n\nsys.path : ")
    # print(sys.path)

    exit(0)

    returnCode = 0
    args = parseArgs()
     
    # (projectYAML, userYAML) = readProjectYAML(
    #     os.getcwd() + "/" + args.projectYAML, os.getcwd() + "/" + args.userYAML
    # )

    if args.runAllChecks:
        for checkType, checkTypeList in userYAML.items():
            if checkType not in projectYAML:
                print(f"ERROR : Check type '{checkType}' not found in project YAML !")
                returnCode = 1

            else:
                for check in checkTypeList:
                    if check not in projectYAML[checkType]:
                        print(
                            f"ERROR : Check '{check}' not found in project YAML for check type '{checkType}' !"
                        )
                        returnCode = 1
                    else:
                        returnCode |= runCheck(projectYAML, checkType, check)

    elif args.runCheck:
        check = args.runCheck
        type = None

        for checkType, checkTypeList in userYAML.items():
            if check in checkTypeList:
                type = checkType
                break

        returnCode |= runCheck(projectYAML, type, check)

    elif args.getAllChecks:
        allChecks = 'echo "checks=['

        for checkType, checkTypeList in userYAML.items():
            if checkType not in projectYAML:
                print(f"ERROR : Check type '{checkType}' not found in project YAML !")
                returnCode = 1

            for check in checkTypeList:
                if check not in projectYAML[checkType]:
                    print(
                        f"ERROR : Check '{check}' not found in project YAML for check type '{checkType}' !"
                    )
                    returnCode = 1
                else:
                    allChecks += f'\\"{check}\\",'

        allChecks += ']" >> "$GITHUB_OUTPUT"'
        allChecks = allChecks.replace(",]", "]")

        print(f"{allChecks}")

    else:
        print(f"\nERROR : Wrong parameters passed !\n")
        returnCode = 1

    exit(returnCode)
