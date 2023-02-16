const express = require('express');
const router = express.Router();
const pool = require('./connect');

router.get('/', function(req, res) {
	pool.getConnection(function(err, connection) {
		if(err) {
            res.statusCode = 500;
            res.statusMessage = "Internal Server Error";
            console.log("Database Connection failed", err);
            res.end();
  		} else {
            query = `SELECT * FROM Session s;`;
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
                    console.log("No Data for sessions");
                    connection.release();
                    res.end();
                } else {

                    res.statusCode = 200;
                    res.statusMessage = "OK";

                    const response = {"sessions":result};	

                    res.json(response);
                    // By default, the character encoding for the response will be set to UTF-8.
                    console.log("json object returned for Sessions query", response);
                    connection.release();
                    res.end();
 
                }
            });
		}
	});
});

module.exports = router;