const axios = require ('axios');
var querystring = require('querystring');

module.exports = function admin_usermod_call(username1, password1, email1, token) {

var obj = new Object();
var username2 = '"'+username1+'"';
var password2 = '"'+password1+'"';
var email2 = '"'+email1+'"';
obj.username = username2;
obj.password = password2;
obj.email = email2;

var usermod = querystring.stringify(obj);

    let url='https://localhost:9103/intelliq_api/admin/usermod/'+username2+'/'+password2+'/'+email2;
axios.post(url, usermod, {headers: { "Content-Type": "application/x-www-form-urlencoded", 'X-OBSERVATORY-AUTH': token}}).then( resp => {
	console.log(resp.data);
    }) .catch(function (error) {
            console.log(error.message, error.response.data);});
}
