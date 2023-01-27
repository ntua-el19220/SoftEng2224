const path = require('path'),
      express = require('express'),
      https = require('https'),
      fs = require('fs'),
      api = express(),
      web = express();

const nunjucks = require('nunjucks');	// templating framework

nunjucks.configure(['../frontend/'], {
    autoescape: false,
    express: web
});

// MIDDLEWARE FOR CROSS-ORIGIN REQUESTS (See Note Below)
const cors = require('cors');
api.use(cors()); web.use(cors());

web.set('view engine', 'html');
web.engine('html', nunjucks.render);

// PARSE THE COOKIES SENT BY CLIENT SIDE TO THE WEB SERVER
// const cookieParser = require('cookie-parser');
// web.use(cookieParser());

const key = fs.readFileSync('sslcert/server.key', 'utf8');
const cert = fs.readFileSync('sslcert/server.crt', 'utf8');
const apiServer = https.createServer({key, cert}, api);
const webServer = https.createServer({key, cert}, web);

const baseURL = '/intelliq_api/',
      apiPORT = process.env.apiPORT || 9103;
// if an environment variable is set then set apiPORT to its value
// otherwise use default port 9103

const multer = require('multer');
const upload = multer({ dest: 'uploads/' });
api.use(upload.single('file'));
const bodyParser = require('body-parser');
api.use(bodyParser.urlencoded({ extended: true }));
api.use(bodyParser.json());

const randomstring = require("randomstring");
const jwtSecretKey = randomstring.generate(20);
const tokenBlacklist = [];
module.exports = {jwtSecretKey, tokenBlacklist}; 
const jwt = require('jsonwebtoken');

api.use((req, res, next) => {
  if (req.path.includes('/login')) return next(); 
  const token = req.get('X-OBSERVATORY-AUTH');
  if (!token) {
    res.statusMessage = "Not authorized";
    res.statusCode = 401;
    console.log("No Token Given");
    res.end();
  } else if (tokenBlacklist.includes(token)) {
    res.statusMessage = "Not authorized";
    res.statusCode = 401;
    console.log("Token used in expired session - User logged out");
    res.end();
  } else {
    jwt.verify(token, jwtSecretKey, (err, decoded) => {
        if (err) {
            res.statusMessage = "Not authorized";
            res.statusCode = 401;
            console.log("Authorization Failed: ", err);
            res.end();
        } else {
            req.decoded = decoded;
            next();
        }
    })
  }
})

// REST API ENDPOINTS
api.use(baseURL+'admin/healthcheck', require('./admin/healthcheck'));
api.use(baseURL+'admin/resetall', require('./admin/resetall'));
api.use(baseURL+'admin/resetq', require('./admin/resetq'));
api.use(baseURL+'admin/users', require('./admin/users'));
api.use(baseURL+'admin/usermod', require('./admin/usermod'));
api.use(baseURL+'admin/questionnaire_upd', require('./admin/questionnaire_upd'));

api.use(baseURL+'questionnaire', require('./questionnaire'));
api.use(baseURL+'question', require('./question'));
api.use(baseURL+'doanswer', require('./doanswer'));
api.use(baseURL+'getsessionanswers', require('./getsessionanswers'));
api.use(baseURL+'getquestionanswers', require('./getquestionanswers'));
api.use(baseURL+'getquestionnaires', require('./getquestionnaires'));
api.use(baseURL+'login', require('./login'));
api.use(baseURL+'logout', require('./logout'));
api.use(baseURL+'createsession', require('./createsession'));
api.use(baseURL+'istheresession', require('./istheresession'));

// FRONTEND ROUTES
web.use(express.static(path.join(__dirname, '..') + "/frontend/assets"));
web.use(express.static(path.join(__dirname, '..') + "/frontend/css"));
web.use(express.static(path.join(__dirname, '..') + "/frontend/js"));

// web.use((req, res, next) => {
//     if (req.path.includes('/login')) return next(); 
//     const token = req.get('X-OBSERVATORY-AUTH');
//     //const token = req.cookies.token;
//     if (!token || tokenBlacklist.includes(token)) {
//         res.redirect('/login');
//         console.log("No Login");
//         res.end();
//     } else {
//         jwt.verify(token, jwtSecretKey, (err, decoded) => {
//             if (err) {
//                 res.redirect('/login');
//                 console.log("No Login");
//                 res.end();
//             } else { console.log("In Active Session"); next(); }
//         })
//     }
// })

web.use("/", require('./routes/Home.js'));
web.use("/login", require('./routes/Login.js'));

apiServer.listen(apiPORT, () => {
    console.log(`API listening at: https://localhost:${apiPORT}${baseURL}`);
});

webServer.listen(8000, () => {
	console.log('Web-server listening at: https://localhost:8000');
});

// Note:
// Cross-origin requests, also known as cross-site requests, occur 
// when a web page on one domain (the "origin") makes a request to 
// a different domain. For example, a web page served from "http://www.example.com" 
// making a request to "http://api.example.com".

// Browsers have a security feature called the same-origin policy, 
// which only allows web pages to make requests to the same domain 
// that served the page. This is to prevent malicious websites from making unauthorized 
// requests to sensitive resources on other sites.