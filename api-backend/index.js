const express = require('express'),
      https = require('https'),
      fs = require('fs'),
      api = express(),
      web = express();

const key = fs.readFileSync('sslcert/server.key', 'utf8');
const cert = fs.readFileSync('sslcert/server.crt', 'utf8');
const apiServer = https.createServer({key, cert}, api);

const baseURL = '/intelliq_api/',
      apiPORT = process.env.apiPORT || 9103;
// if an environment variable is set then set apiPORT to its value
// otherwise use default port 9103

// REST API ENDPOINTS
api.use(baseURL+'admin/healthcheck', require('./admin/healthcheck'));
api.use(baseURL+'admin/resetall', require('./admin/resetall'));
api.use(baseURL+'admin/resetq', require('./admin/resetq'));

api.use(baseURL+'questionnaire', require('./questionnaire'));
api.use(baseURL+'question', require('./question'));
api.use(baseURL+'doanswer', require('./doanswer'));
api.use(baseURL+'getsessionanswers', require('./getsessionanswers'));
api.use(baseURL+'getquestionanswers', require('./getquestionanswers'));

apiServer.listen(apiPORT, () => {
    console.log(`API listening at: https://localhost:${apiPORT}${baseURL}`);
});