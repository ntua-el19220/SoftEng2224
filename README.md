# Software Engineering Project 2022-2023

**Group: (SoftEng22-24)**
Members: el19145, el19220,el19172, el19866, el19923,el19116 
  
-- API BRANCH 
Instructions:
Type at the terminal "python run.py" in order to start the app.
It resets the database.

For testing purposes there is the sript "runFast.py".
You can type "python runFast.py" in order to start the app faster.
It doesnt reset the database.
Note: Remember to change the mysql credentials at runFast.py:
 e.g.   os.environ["usernameMYSQL"] = "root"
        os.environ["passwordMYSQL"] = "root1234"

Whats implemented:
- All mandatory API endpoints 
Exception: Endpoint {baseURL}/admin/questionnaire_upd
isnt implemented yet as it requires the correspondent 
frontend elements.

The API is not tested thoroughly. 
Further testing is necessary 
(using Postman https://www.postman.com).
