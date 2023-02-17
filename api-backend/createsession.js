const express = require('express');
const router = express.Router();
const pool = require('./connect');

router.post('/:questionnaireID/:session', function(req, res) {
    let {questionnaireID, session} = req.params;
    const userID = req.decoded.userID;
	pool.getConnection(function(err, connection) {
		if(err) {
            res.statusCode = 500;
            res.statusMessage = "Internal Server Error";
            console.log("Database Connection failed", err);
            res.end();
  		} else {
            query = `SELECT randomsession();`;
            connection.query(query, function(err, result) {
                if(err) {
                    res.statusCode = 400;
                    res.statusMessage = "Bad Request";
                    console.log("Bad request given", err);
                    connection.release();
                    res.end();
                } else { 
                    if (session == "\"\"") // if session is not given generate one
                        session = '"'+result[0]['randomsession()']+'"';
                    query_2 = `INSERT INTO Session (session, userID, questionnaireID) VALUES (${session}, ${userID}, ${questionnaireID});`;
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
                            console.log("Session Created");
                            res.status(200).json({message:"Session Created", session:session});
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