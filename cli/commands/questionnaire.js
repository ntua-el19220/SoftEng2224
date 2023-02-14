const axios = require ('axios');

module.exports = function questionnaire_call(questionnaire_id1, format, token) {
var questionnaire_id = '"'+questionnaire_id1+'"';


    let url='https://localhost:9103/intelliq_api/questionnaire/'+questionnaire_id+'?format='+format;
    axios.get(url, {
        headers: { 
        'X-OBSERVATORY-AUTH': token}
      }).then( resp => {
        console.log(resp.data);
    }) .catch(function (error) {
            console.log(error.message, error.response.data);});
}
