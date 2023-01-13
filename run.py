import subprocess
import os

######################## install python dependencies ####################################
try:
    subprocess.run('pip install -r requirements.txt', shell=True, check=True)
except: 
    print("Error occured while installing the requirements")
    exit(-1) # error 
print("Requirements installed successfully")

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

os.chdir(api_backendPath)
# change directory to absolute path

try:
    subprocess.run('npm install', shell=True, check=True)
except: 
    print("Error occured while installing node dependencies for api-backend")
    exit(-1) # error 
print("Dependencies for api-backend installed successfully")

# The nmp (Node Package Manager) command will install the 
# dependencies recorded in the package.json file

########################## install node modules for CLI ###################################
cliPath = os.path.join(projPath, "cli")
os.chdir(cliPath)

try:
    subprocess.run('npm install', shell=True, check=True)
except: 
    print("Error occured while installing node dependencies for cli")
    exit(-1) # error 
print("Dependencies for cli installed successfully")

################################ create the database #####################################

print("Give MySQL credentials")
userMYSQL = input("Give the username (e.g. root): ")  
passwordMYSQL = input("Give the password: ")  
createSchemaPath = os.path.join(projPath, "data", "db_intelliq_draft", "intelliQ_schema_creation.sql")
print(createSchemaPath)
createViewsPath = os.path.join(projPath, "data", "db_intelliq_draft", "create_views_intelliq.sql")

try:
    subprocess.run('mysql -u{} -p"{}" < "{}"'.format(userMYSQL, passwordMYSQL, createSchemaPath), shell=True, check=True)
except: 
    print("Error occured while creating the database")
    exit(-1) # error 
print("Database created successfully")

try:
    subprocess.run('mysql -u{} -p"{}" < "{}"'.format(userMYSQL, passwordMYSQL, createViewsPath), shell=True, check=True)
except: 
    print("Error occured while creating the views")
    exit(-1) # error 
print("Views created successfully")

#################################### insert data ########################################

################################ start the database #####################################