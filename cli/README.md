# CLI
---

**Initial file** :
- index.js

**Requirements ("npm install" if needed, usually handled by run.py)** :
- node.js
- commander
- axios
- program
- python-shell
- form-data (npm install --save form-data)
- fs
- querystring

**How to run**:
- In folder "cli" run command "npm install -g"
- Calling parameter is "se2224"
- Use command createsession to be able to answer a questionnaire
- Add parameter "-h" or "--h" for help additional info
- Use command admin --usermod to register new users
- Usernames must be alphanumeric latin characters
- Passwords can be anything (no spaces)
- Parameter --format is either json or csv (default is json)
- Parameter --source is the path or name of the json file that contains the questionnaire

- User Command Formats:<br />
&nbsp; &nbsp; &nbsp; se2224 login --username _username_ --password _password_<br />
&nbsp; &nbsp; &nbsp; se2224 logout<br />
&nbsp; &nbsp; &nbsp; se2224 healthcheck<br />
&nbsp; &nbsp; &nbsp; se2224 resetall<br />
&nbsp; &nbsp; &nbsp; se2224 questionnaire_upd --source _source_<br />
&nbsp; &nbsp; &nbsp; se2224 resetq --questionnaire_id _questionnaire_id_<br />
&nbsp; &nbsp; &nbsp; se2224 questionnaire --questionnaire_id _questionnaire_id_ --format _format_<br />
&nbsp; &nbsp; &nbsp; se2224 createsession --questionnaire_id _questionnaire_id_
&nbsp; &nbsp; &nbsp; se2224 question --questionnaire_id _questionnaire_id_ --question_id _question_id_ --format _format_<br />
&nbsp; &nbsp; &nbsp; se2224 doanswer --questionnaire_id _questionnaire_id_ --question_id _question_id_ --session_id _session_id_ --option_id _option_id_<br />
&nbsp; &nbsp; &nbsp; se2224 getsessionanswers --questionnaire_id _questionnaire_id_ --session_id _session_id_ --format _format_<br />
&nbsp; &nbsp; &nbsp; se2224 getquestionanswers --questionnaire_id _questionnaire_id_ --question_id _question_id_ --format _format_<br />

- Admin Command Formats:<br />
&nbsp; &nbsp; &nbsp; se2224 admin --usermod --username _username_ --password _password_<br />
&nbsp; &nbsp; &nbsp; se2224 admin --users _username_ --format _format_<br />
