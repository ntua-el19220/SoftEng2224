const express = require('express');
const router = express.Router();
const pool = require('./connect');
const jwt = require('jsonwebtoken')
const {jwtSecretKey} = require('./index');

router.post('/', function(req, res) {
    const {username, password} = req.body;

    pool.getConnection(function(err, connection) {
		if(err) {
            res.statusCode = 500;
            res.statusMessage = "Internal Server Error";
            console.log("Database Connection failed", err);
            connection.release();
            res.end();
  		} else {
            if (username == '"AnonymousUser"') {
                query = `INSERT INTO Anonymous () VALUES ();`;
                connection.query(query, function(err, result) {
                    if(err) {
                        res.statusCode = 400;
                        res.statusMessage = "Bad Request";
                        console.log("Bad request given", err);
                        connection.release();
                        res.end();
                    } else {
                        query = `SELECT value FROM latestUserIDinserted;`;
                        connection.query(query, function(err, result) {
                            if(err) {
                                res.statusCode = 400;
                                res.statusMessage = "Bad Request";
                                console.log("Bad request given", err);
                                connection.release();
                                res.end();
                            } else {
                                res.statusCode = 200;
                                res.statusMessage = "OK";
                                const payload ={
                                    userID: result[0].value,
                                    username: "Anonymous",
                                    password: "",
                                    email: "",
                                    exp:(Date.now()/1000+3600), // expires in 1hour
                                    iat: Date.now()
                                    // The Date.now() method returns the number of 
                                    // milliseconds that have elapsed since 
                                    // January 1, 1970 00:00:00 UTC
                                }
                                const token = jwt.sign(payload, jwtSecretKey);
                                // res.cookie('token', token, { httpOnly: true });
                                // the browser will include the cookie in https requests automatically
                                res.json({ token: token });
                                console.log("Successful Login");
                                connection.release();
                                res.end();
                            }
                        });
                    }
                });
            } else {
                query = `SELECT * FROM Identified WHERE username = ${username} AND password = MD5(${password});`;
                connection.query(query, function(err, result) {
                    if(err) {
                        res.statusCode = 400;
                        res.statusMessage = "Bad Request";
                        console.log("Bad request given", err);
                        connection.release();
                        res.end();
                    } else if (result.length == 0) {
                        res.statusMessage = "Not authorized";
                        res.statusCode = 401;
                        console.log("Wrong Credentials");
                        connection.release();
                        res.end();
                    } else {
                        res.statusCode = 200;
                        res.statusMessage = "OK";
    
                        const payload ={
                            userID: result[0].userID,
                            username: result[0].username,
                            password: result[0].password,
                            email: result[0].email,
                            exp:(Date.now()/1000+3600), // expires in 1hour
                            iat: Date.now()
                            // The Date.now() method returns the number of 
                            // milliseconds that have elapsed since 
                            // January 1, 1970 00:00:00 UTC
                        }
                        const token = jwt.sign(payload, jwtSecretKey);
                        // res.cookie('token', token, { httpOnly: true });
                        // the browser will include the cookie in https requests automatically
                        res.json({ token: token });
                        console.log("Successful Login");
                        connection.release();
                        res.end();
                    }
                });
            }
		}
	});
});
  
module.exports = router;