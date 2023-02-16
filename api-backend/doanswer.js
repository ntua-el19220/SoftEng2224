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
            const query_1 = `SELECT * FROM Session s \
                           INNER JOIN Question q ON s.questionnaireID = q.questionnaireID \
                           INNER JOIN \`Option\` o ON q.qID = o.qID \
                           WHERE s.session = ${session} AND q.qID = ${questionID} AND o.optID = ${optionID} AND s.questionnaireID = ${questionnaireID};`;
            connection.query(query_1, function(err, result_1) {
                if(err) {
                    res.statusCode = 400;
                    res.statusMessage = "Bad Request";
                    console.log("Bad request given", err);
                    connection.release();
                    res.end();
                } else if (result_1.length == 0) {
                    res.statusCode = 400;
                    res.statusMessage = "Bad Request";
                    console.log("Bad request given-Invalid arguments given");
                    connection.release();
                    res.end();
                } else { 
                    const query_2 = `INSERT INTO Answer (session, optID) VALUES (${session}, ${optionID});`; 
                    connection.query(query_2, function(err, result_2) {
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
		}
	});
});

module.exports = router;