const axios = require ('axios');

module.exports = function admin_users_call(username1, format, token) {

var username2 = '"'+username1+'"';

    let url='https://localhost:9103/intelliq_api/admin/users/'+username2+'?format='+format;
    axios.get(url, {
              headers: { 'X-OBSERVATORY-AUTH': token}}).then(resp=>{
              console.log(resp.data);
            });
}
