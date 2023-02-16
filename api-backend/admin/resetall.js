const express = require('express');
const router = express.Router();
const pool = require('../connect');
const fs = require('fs');

var insertSQL = fs.readFileSync('../data/db_intelliq_draft/insert.sql').toString();

router.post('/', function(req, res) {
	pool.getConnection(function(err, connection) {
		if(err) {
            res.statusMessage = "Internal Server Error";
            res.status(500).json({status:"failed", "reason":"No Connection to the Database"});
            console.log("Database Connection failed", err);
            res.end();
  		} else {

            query = "DELETE FROM Answer;\
                     DELETE FROM Session;\
                     DELETE FROM Identified;\
                     DELETE FROM Anonymous;\
                     DELETE FROM \`Option\`;\
                     DELETE FROM Question;\
                     DELETE FROM User;\
                     DELETE FROM Keyword;\
                     DELETE FROM Questionnaire; \
                     UPDATE latestUserIDinserted set value = 0; \
                     ALTER TABLE User AUTO_INCREMENT=1;";

            connection.query(query, function(err) {
                if(err) {
                    res.statusMessage = "Bad Request";
                    res.status(500).json({status:"failed", "reason":"Deletion of the data unsuccessful" + ' ' + err});
                    console.log("Deletion of the data unsuccessful", err);
                    connection.release();
                    res.end();
                } else {
                    connection.query(insertSQL, function(err) {
                        if(err) {
                            res.statusMessage = "Bad Request";
                            res.status(500).json({status:"failed", "reason":"Insertion of the data unsuccessful" +' ' + err});
                            console.log("Insertion of the data unsuccessful", err);
                            connection.release();
                            res.end();
                        } else {
                            res.status(200).json({status:"OK"});
                            console.log("Reset of the Database successful");
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