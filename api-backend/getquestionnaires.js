const express = require('express');
const router = express.Router();
const pool = require('./connect');
const json2csv = require('json2csv').parse;

router.get('/', function(req, res) {
	pool.getConnection(function(err, connection) {
		if(err) {
            res.statusCode = 500;
            res.statusMessage = "Internal Server Error";
            console.log("Database Connection failed", err);
            connection.release();
            res.end();
  		} else {
            query = "SELECT * FROM Questionnaire;";
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
                    console.log("No Questionnaires");
                    connection.release();
                    res.end();
                } else {

                    res.statusCode = 200;
                    res.statusMessage = "OK";

                    if (req.query.format === "csv") {
                        const fields = ["questionnaireID", "questionnaireTitle", "dateUpdated"];
                        const data = header + '\n' + json2csv(result, {fields});
                        console.log("csv returned for Questionnaires query", data);
                        connection.release();
                        res.send(data);
                    } else { // when query is ommited json is returned

                        const response = {
                            "questionnaires":result
                        }	

                        res.json(response);
                        // By default, the character encoding for the response will be set to UTF-8.
                        console.log("json object returned for Questionnaires query", response);
                        connection.release();
                        res.end();
                    } 
                }
            });
		}
	});
});

module.exports = router;