const axios = require ('axios');
const FormData = require('form-data');
const fs = require('fs');

module.exports = function questionnaire_upd_call(source, token) {

  const form = new FormData();
 
  form.append('file', fs.createReadStream(source));

    let url='https://localhost:9103/intelliq_api/admin/questionnaire_upd'
    axios.post(url, form, {
        headers: { 
        'X-OBSERVATORY-AUTH': token,
        'Content-Type' : 'multipart/form-data'}
      }).then( resp => {
        console.log(resp.data);
    });
}
