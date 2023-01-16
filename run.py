import subprocess
import os

######################## install python dependencies ####################################
import sys

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
insertDataPath = os.path.join(projPath, "data", "db_intelliq_draft", "insert.sql")

try:
    subprocess.run('mysql -u{} -p"{}" < "{}"'.format(userMYSQL, passwordMYSQL, createSchemaPath), shell=True, check=True)
except: 
    print("Error occured while creating the database")
    exit(-1) # error 
print("Database created successfully")

try:
    subprocess.run('mysql -u{} -p"{}" < "{}"'.format(userMYSQL, passwordMYSQL, insertDataPath), shell=True, check=True)
except: 
    print("Error occured while inserting data in the database")
    exit(-1) # error 
print("Data Inserted successfully")



try:
    os.environ["usernameMYSQL"] = userMYSQL
    os.environ["passwordMYSQL"] = passwordMYSQL
    # set environment variables for child processes
except: 
    print("Error occured while creating the environment variables")
    exit(-1) # error 
print("Environment variables created successfully")

#################################### insert data ########################################

############################# generate https credentials #################################

# For the generation of the certification's credentials we followed the instructions:
# https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-16-04

try:
    os.chdir(api_backendPath)
    if not os.path.exists("./sslcert"):
        os.makedirs("./sslcert")
    os.chdir("./sslcert")
    subprocess.run('sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./server.key -out server.crt -subj "/C=GR/ST=Attiki/L=Athens/O=ECENTUA/OU=Team24/CN=localhost/emailAddress=softeng22-24@mail.ntua.com"', shell=True, check=True)
    if sys.platform == "darwin":            #added system login in case macos user runs the script
        subprocess.run('sudo chown -R {} ./'.format(os.getlogin()), shell=True, check=True)
    else:
        subprocess.run('sudo chown {} -R ./'.format(os.environ.get('USERNAME')), shell=True, check=True)
except: 
    print("Error occured while creating HTTPS credentials")
    exit(-1) # error 
print("HTTPS credentials created successfully")

################################ start the server #######################################
os.chdir(api_backendPath)
try:
    subprocess.run('node index.js', shell=True, check=True)
except: 
    print("Error occured while starting the server")
    exit(-1) # error 