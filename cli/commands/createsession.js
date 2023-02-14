const axios = require ('axios');

module.exports = function session_call(questionnaire_id1, session_id1, token) {
var questionnaire_id = '"'+questionnaire_id1+'"';
var session_id = '"'+session_id1+'"';

    let url='https://localhost:9103/intelliq_api/createsession/'+questionnaire_id+'/'+session_id;
   axios.post(url, session_id, {
        headers: { 
        'X-OBSERVATORY-AUTH': token}
      }).then( resp => {
        console.log(resp.data);
    });
}
