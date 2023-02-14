const axios = require ('axios');
const fs = require('fs');
var querystring = require('querystring');

module.exports = function login_call(username1, password1) {

var obj = new Object();
var username2 = '"'+username1+'"';
var password2 = '"'+password1+'"';
obj.username = username2;
obj.password = password2;

var loginjson = querystring.stringify(obj);

let url='https://localhost:9103/intelliq_api/login/'
axios.post(url, loginjson, {headers: { "Content-Type": "application/x-www-form-urlencoded"}}).then( resp => {
	console.log(resp.data);
	fs.writeFile('Intelliq_token.txt', resp.data.token, {encoding: 'utf8'}, function(err){if(err){console.log(err);}});
       // write resp.data.token to a config file;
    });
}
