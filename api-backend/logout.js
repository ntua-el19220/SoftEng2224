const express = require('express');
const router = express.Router();
const pool = require('./connect');
const jwt = require('jsonwebtoken')
const {jwtSecretKey, tokenBlacklist} = require('./index');

router.post('/', function(req, res) {
    const token = req.get('X-OBSERVATORY-AUTH');
    tokenBlacklist.push(token);
    res.statusCode = 200;
    res.statusMessage = "OK";
    console.log("Logout Successful");
    res.end();
});
  
// add clearBlacklist() 

module.exports = router;