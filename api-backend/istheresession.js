const express = require('express');
const router = express.Router();
const pool = require('./connect');
const randomstring = require("randomstring");

router.get('/:questionnaireID', function(req, res) {
    const {questionnaireID} = req.params;
    const userID = req.decoded.userID;
	pool.getConnection(function(err, connection) {
		if(err) {
            res.statusCode = 500;
            res.statusMessage = "Internal Server Error";
            console.log("Database Connection failed", err);
            connection.release();
            res.end();
  		} else {
            query_1 = `SELECT * FROM Session s WHERE s.questionnaireID = ${questionnaireID} AND s.userID = ${userID};`;
            connection.query(query_1, function(err, result_1) {
                if(err) {
                    res.statusCode = 400;
                    res.statusMessage = "Bad Request";
                    console.log("Bad request given", err);
                    connection.release();
                    res.end();
                } else if (result_1.length != 0) {
                    res.statusCode = 200;
                    res.statusMessage = "OK";
                    res.status(200).json({message:"Questionnaire already answered by the user"});
                    console.log("Questionnaire already answered by the user");
                    connection.release();
                    res.end();
                } else {
                    const session = randomstring.generate(4);
                    res.statusCode = 200;
                    res.statusMessage = "OK";
                    res.status(200).json({message:"Questionnaire not answered by the user", session:session});
                    console.log("Questionnaire not answered by the user");
                    connection.release();
                    res.end();
                }
            });
		}
	});
});

module.exports = router;