const express = require('express');
const router = express.Router();
const pool = require('./connect');
const json2csv = require('json2csv').parse;

router.get('/:questionnaireID/:session', function(req, res) {
    const {questionnaireID, session} = req.params;
	pool.getConnection(function(err, connection) {
		if(err) {
            res.statusCode = 500;
            res.statusMessage = "Internal Server Error";
            console.log("Database Connection failed", err);
            connection.release();
            res.end();
  		} else {
            query = `SELECT s.questionnaireID, s.session, q.qID,a.optID \
                     FROM Session s \
                     INNER JOIN Answer a ON s.session = a.session \
                     INNER JOIN \`Option\` o ON a.optID = o.optID \
                     INNER JOIN Question q ON o.qID = q.qID \
                     WHERE s.session = ${session} ORDER BY q.qID;`;
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
                    console.log("No Data for Answers of the given session");
                    connection.release();
                    res.end();
                } else {

                    res.statusCode = 200;
                    res.statusMessage = "OK";

                    let answers = result.map(function(obj) { // isolate answers
                        let newObj = Object.assign({}, obj);
                        newObj.ans = obj.optID; // rename optID to ans
                        delete newObj.optID;
                        delete newObj.questionnaireID;
                        delete newObj.session;
                        return newObj;
                    });
                    if (req.query.format === "csv") {
                        const header = json2csv({"questionnaireID":result[0].questionnaireID,
                                                 "session":result[0].session});
                        const fields = ["qID", "ans"];
                        const data = header + '\n' + json2csv(answers, {fields});
                        console.log("csv returned for Answers of Session query", data);
                        connection.release();
                        res.send(data);
                    } else { // when query is ommited json is returned

                        const response = {
                            "questionnaireID":result[0].questionnaireID,
                            "session":result[0].session,
                            "answers":answers
                        }	

                        res.json(response);
                        // By default, the character encoding for the response will be set to UTF-8.
                        console.log("json object returned for Answers of Session query", response);
                        connection.release();
                        res.end();
                    } 
                }
            });
		}
	});
});

module.exports = router;