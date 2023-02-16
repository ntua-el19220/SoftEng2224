const express = require('express');
const router = express.Router();
const pool = require('../connect');

router.post('/:username/:password/:email', function(req, res) {
    const {username, password, email} = req.params;
	pool.getConnection(function(err, connection) {
		if(err) {
            res.statusCode = 500;
            res.statusMessage = "Internal Server Error";
            console.log("Database Connection failed", err);
            res.end();
  		} else {
            const checkQuery = `SELECT * FROM Identified WHERE username = ${username};`;
            connection.query(checkQuery, function(err, result) {
                if(err) {
                    res.statusCode = 400;
                    res.statusMessage = "Bad Request";
                    console.log("Bad request given", err);
                    connection.release();
                    res.end();
                } else if (result.length == 0) {
                    const query = `INSERT INTO Identified (email, username, password) VALUES (${email}, ${username}, MD5(${password}));`; 
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
                            console.log("User Created");
                            connection.release();
                            res.end();
                        } 
                    });
                } else {
                    const query = `UPDATE Identified SET password = MD5(${password}) \
                                   WHERE username = ${username};`; 
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
                            console.log("Password updated");
                            connection.release();
                            res.end();
                        } 
                    });
                }
            });

		}
	});
});

module.exports = router;