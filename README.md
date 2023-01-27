# Software Engineering Project 2022-2023

**Group: (SoftEng22-24)**
Members: el19145, el19220,el19172, el19866, el19923,el19116 
  
-- Frontend BRANCH 
Instructions:
Type at the terminal "python run.py" in order to start the app.
It resets the database.
Copy the insert.sql and intelliQ_schema_creation.sql from the Database branch to the folder data/db_intelliq_draft

For testing purposes there is the sript "runFast.py".
You can type "python runFast.py" in order to start the app faster.
It doesnt reset the database.
Note: Remember to change the mysql credentials at runFast.py:
 e.g.   os.environ["usernameMYSQL"] = "root"
        os.environ["passwordMYSQL"] = "root1234"

What's implemented:
- All API endpoints 
- Frontend basic functionalities

Frontend isnt fully ready! 
However the CLI/API testing can be done from the API's code included in this branch, which is completed.

Website available at https://localhost:8000/