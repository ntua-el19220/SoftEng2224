const express = require('express');
const router = express.Router();
const pool = require('./connect');

router.post('/:questionnaireID/:questionID/:session/:optionID', function(req, res) {
    const {questionnaireID, questionID, session, optionID} = req.params;
	pool.getConnection(function(err, connection) {
		if(err) {
            res.statusCode = 500;
            res.statusMessage = "Internal Server Error";
            console.log("Database Connection failed", err);
            connection.release();
            res.end();
  		} else {
            const query = `INSERT INTO Answer (session, optID) VALUES ('${session}', '${optionID}');`;
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
                    console.log("Answer to question updated");
                    connection.release();
                    res.end();
                } 
            });
		}
	});
});

module.exports = router;