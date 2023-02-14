const axios = require ('axios');

module.exports = function getquestionanswers_call(questionnaire_id1, question_id1, format, token) {
var questionnaire_id = '"'+questionnaire_id1+'"';
var question_id = '"'+question_id1+'"';

    let url='https://localhost:9103/intelliq_api/getquestionanswers/'+questionnaire_id+'/'+question_id+'?format='+format;
axios.get(url, {
        headers: { 
        'X-OBSERVATORY-AUTH': token}
      }).then( resp => {
        console.log(resp.data);
    });
}
