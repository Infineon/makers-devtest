#!/usr/bin/python3


# python.exe bin/build.py


import argparse, glob, os, re, subprocess, sys, yaml


sys.path.insert(1, "exampleFlow/src/python")


from project_yaml.readProjectYAML import readProjectYAML

# from check_schemata.checkProjectYAMLSchema import checkProjectYAMLSchema
# from check_schemata.checkUserYAMLSchema import checkUserYAMLSchema


if __name__ == "__main__":
    # parser()

    buildJob = None
    ret = 0

    if sys.argv[1] == "--runBuildJob":

        buildJob = sys.argv[2]
        print(f"python : Running job {buildJob} ...")
        print(f"python : Running job {buildJob} done.")
        ret = 1

    elif sys.argv[1] == "--getBuildJobs":

        with open("exampleFlow/project.yml", "r") as file:
            projectYAML = yaml.safe_load(file)

        # checkProjectYAMLSchema(importedProjectYAML)

        with open("exampleFlow/user.yml", "r") as file:
            userYAML = yaml.safe_load(file)

        # checkUserYAMLSchema(userYAML)

        jobs = 'echo "build_jobs=['
        numJobs = len(userYAML["build"])
        i = 0

        for job in userYAML["build"]:
            jobs += f'\\"{job}\\"'
            i += 1

            if not i == numJobs:
                jobs += ","

        jobs += ']" >> "$GITHUB_OUTPUT"'

        print(f"{jobs}")
        # print('echo "fqbn=[\\"Infineon.xmc.XMC4700_Relax_Kit\\", \\"Infineon.xmc.XMC1400_XMC2GO\\"]" >> "$GITHUB_OUTPUT"')

    else:
        print(f"\nERROR : Wrong parameters passed !\n")
        ret = 1

    print(f"{sys.argv[0]} done.")

    exit(ret)
