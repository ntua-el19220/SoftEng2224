# ONLY FOR TESTING PURPOSES

import subprocess
import os

# The subprocess.run() function is used to run a command in 
# the shell and raise a CalledProcessError if the return code is non-zero. 
# In this case, the command being run is pip install -r requirements.txt, 
# which installs all the packages listed in the requirements.txt file using 
# the pip package manager. The shell=True argument is used to run the command 
# in the shell, rather than in the current Python process.
# The check=True argument means that if the return code of the command is 
# non-zero, a CalledProcessError will be raised. If check=False is used, 
# the method will return a CompletedProcess with the attributes of the 
# process execution, but the exception will not be raised.

projPath = os.path.dirname(os.path.abspath(__file__))
# __file__ is a special variable in Python that contains the name of the 
# current script or module. 
# os.path.dirname(__file__) gets the directory component of the current python file.
# os.path.abspath() returns the absolute path of the file

####################### install node modules for api-backend ##############################
api_backendPath = os.path.join(projPath, "api-backend")
# example: os.path.join('home','user','documents','files')
# outputs home/user/documents/files

try:
    os.environ["usernameMYSQL"] = "root"
    os.environ["passwordMYSQL"] = "root1234"
    # set environment variables for child processes
except: 
    print("Error occured while creating the environment variables")
    exit(-1) # error 
print("Environment variables created successfully")

################################ start the server #######################################
os.chdir(api_backendPath)
try:
    subprocess.run('node index.js', shell=True, check=True)
except: 
    print("Error occured while starting the server")
    exit(-1) # error 