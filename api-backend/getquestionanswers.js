const express = require('express');
const router = express.Router();
const pool = require('./connect');
const json2csv = require('json2csv').parse;

router.get('/:questionnaireID/:questionID', function(req, res) {
    const {questionnaireID, questionID} = req.params;
	pool.getConnection(function(err, connection) {
		if(err) {
            res.statusCode = 500;
            res.statusMessage = "Internal Server Error";
            console.log("Database Connection failed", err);
            connection.release();
            res.end();
  		} else {
            query = `SELECT q.questionnaireID, q.qID, s.session, a.optID \
                     FROM Question q \
                     INNER JOIN \`Option\` o ON q.qID = o.qID \
                     INNER JOIN Answer a ON a.optID = o.optID \
                     INNER JOIN Session s ON a.session = s.session \
                     WHERE q.qID = ${questionID} AND q.questionnaireID = ${questionnaireID} \
                     ORDER BY s.created_at;`;
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
                    console.log("No Data for Answers of the given question");
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
                        delete newObj.qID;
                        return newObj;
                    });
                    if (req.query.format === "csv") {
                        const header = json2csv({"questionnaireID":result[0].questionnaireID,
                                                 "questionID":result[0].qID});
                        const fields = ["session", "ans"];
                        const data = header + '\n' + json2csv(answers, {fields});
                        console.log("csv returned for Answers of Questionnaire query", data);
                        connection.release();
                        res.send(data);
                    } else { // when query is ommited json is returned

                        const response = {
                            "questionnaireID":result[0].questionnaireID,
                            "questionID":result[0].qID,
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