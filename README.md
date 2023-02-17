# Software Engineering Project 2022-2023 - intelliq

**Group: (SoftEng22-24)**
Members: el19145, el19220,el19172, el19866, el19923,el19116 
  
## Requirements
- MySQL
- Nodejs
- Express

## How to deploy
Just type : `python3 run.py`
It resets the database and runs the webserver.

For testing purposes there is the sript "runFast.py".
You can type "python3 runFast.py" in order to start the app faster.
It doesnt reset the database.
Note: Remember to change the mysql credentials at runFast.py:
 e.g.   os.environ["usernameMYSQL"] = "root"
        os.environ["passwordMYSQL"] = "root1234"

Website available at https://localhost:8000/

## Code license
The code in this repository is licensed under the MIT license.