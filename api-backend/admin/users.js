const express = require('express');
const router = express.Router();
const pool = require('../connect');
const json2csv = require('json2csv').parse;

router.get('/:username', function(req, res) {
    const {username} = req.params;
	pool.getConnection(function(err, connection) {
		if(err) {
            res.statusCode = 500;
            res.statusMessage = "Internal Server Error";
            console.log("Database Connection failed", err);
            res.end();
  		} else {
            query = `SELECT u.userID, u.username, u.password, u.email \
                    FROM Identified u WHERE u.username = ${username};`;
            connection.query(query, function(err, result) {
                if(err) {
                    res.statusCode = 400;
                    res.statusMessage = "Bad Request";
                    console.log("Bad request given", err);
                    connection.release();
                    res.end();
                } else if (result.length == 0) {
                    res.statusCode = 402;
                    res.statusMessage = "No Data";
                    console.log("No Data for given User ID");
                    connection.release();
                    res.end();
                } else {

                    res.statusCode = 200;
                    res.statusMessage = "OK";

                    if (req.query.format === "csv") {
                        const fields = ["userID", "username", "password", "email"];
                        result[0].userID = JSON.stringify(result[0].userID);
                        const data = json2csv(result, {fields});
                        console.log("csv returned for users query", data);
                        connection.release();
                        res.send(data);
                    } else { // when query is ommited json is returned

                        const response = {
                            "userID":JSON.stringify(result[0].userID),
                            "username":result[0].username,
                            "password":result[0].password,
                            "email":result[0].email
                        }	

                        res.json(response);
                        // By default, the character encoding for the response will be set to UTF-8.
                        console.log("json object returned for users query", response);
                        connection.release();
                        res.end();
                    } 
                }
            });
		}
	});
});

module.exports = router;