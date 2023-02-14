const axios = require ('axios');

module.exports = function resetq_call(questionnaire_id1, token) {

var questionnaire_id = '"'+questionnaire_id1+'"';


    let url='https://localhost:9103/intelliq_api/admin/resetq/'+questionnaire_id;
    axios.post(url, questionnaire_id, {
        headers: { 
        'X-OBSERVATORY-AUTH': token}
      }).then( resp => {
        console.log(resp.data);
    });
}
