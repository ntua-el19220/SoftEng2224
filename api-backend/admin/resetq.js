const express = require('express');
const router = express.Router();
const pool = require('../connect');

router.post('/:questionnaireID', function(req, res) {
    const {questionnaireID} = req.params;
	pool.getConnection(function(err, connection) {
		if(err) {
            res.statusMessage = "Internal Server Error";
            res.status(500).json({status:"failed", "reason":"No Connection to the Database"});
            console.log("Database Connection failed", err);
            res.end();
  		} else {

            query = `DELETE FROM Session where questionnaireID = ${questionnaireID};`;
            connection.query(query, function(err) {
                if(err) {
                    res.statusMessage = "Bad Request";
                    res.status(500).json({status:"failed", "reason":"Deletion of the data unsuccessful" + ' ' + err});
                    console.log("Deletion of the answers of the questionnaire unsuccessful", err);
                    connection.release();
                    res.end();
                } else {
                    res.status(200).json({status:"OK"});
                    console.log("Deletion of Answers of the given questionnaire successful");
                    connection.release();
                    res.end();
                }
            });
		}
	});
});

module.exports = router;