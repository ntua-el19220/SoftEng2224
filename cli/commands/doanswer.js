const axios = require ('axios');
const fs = require('fs');
var querystring = require('querystring');

module.exports = function doanswer_call(questionnaire_id1, question_id1, session_id1, option_id1, token) {

var obj = new Object();
var questionnaire_id2 = '"'+questionnaire_id1+'"';
var question_id2 = '"'+question_id1+'"';
var session_id2 = '"'+session_id1+'"';
var option_id2 = '"'+option_id1+'"';

obj.questionnaire_id = questionnaire_id2;
obj.question_id = question_id2;
obj.session_id = session_id2;
obj.option_id = option_id2;

var answerjson = querystring.stringify(obj);


    let url='https://localhost:9103/intelliq_api/doanswer/'+questionnaire_id2+'/'+question_id2+'/'+session_id2+'/'+option_id2;
    axios.post(url, answerjson, {
        headers: { 
        'X-OBSERVATORY-AUTH': token}
      }).then( resp => {
        console.log(resp.data);
    }) .catch(function (error) {
            console.log(error.message, error.response.data);});
}
