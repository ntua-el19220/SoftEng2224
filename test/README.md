# FOR API TESTING

Check the API Testing report which is the file "Επίδειξη API_Testing" for an extensive description of our Testing Postman Collection.

Some information:

1. To login as Admin use credentials: username : "Admin" , password : "Admin123".
2. To login as Anonymous User use credentials: username: "AnonymousUser", password: "".
3. The login token must be added as a header to every other HTTP request you want to make. Our collection uses a Collection Variable 
called token so the tester does not have to do it by hand every time he/she wants to make a request.
4. To use {baseURL}/admin/questionnaire_upd endpoint you must be logged in as admin and add a .json file that carries the questionnaire you want to upload 
to the body of your request.
We provide such a file called "Questionnaire_gia_exetash.json" in the previous (..) directory. You have to add the file to Postman's working directory
or turn on the option "Allow reading files outside working directory" from Postman : File -> Settings -> Allow reading files outside working directory. 
You should find that option on the bottom left of the Settings tab.
5. Before making a request to {baseURL}/doanswer/:questionnaireID/:questionID/:session/:optionID we must first call the endpoint {baseURL}/createsession/:questionnaire
ID/:session which creates a Session with SessionID = session for the Questionnaire with questinaireID. This createsession endpoint was added so that a frontend user
can answer a Questionnaire without having to insert a SessionID.

#### For more information check the report.
