const express = require('express');
const router = express.Router();
const pool = require('./connect');
const json2csv = require('json2csv').parse;

router.get('/:questionnaireID', function(req, res) {
    const {questionnaireID} = req.params;
	pool.getConnection(function(err, connection) {
		if(err) {
            res.statusCode = 500;
            res.statusMessage = "Internal Server Error";
            console.log("Database Connection failed", err);
            connection.release();
            res.end();
  		} else {
            query_1 = `SELECT questionnaireID, questionnaireTitle \
                       FROM Questionnaire \
                       WHERE questionnaireID = ${questionnaireID};`;                        /* this variables will be in quitation through the front end implementation */

            query_2 = `SELECT k.word \
                       FROM Keyword k \
                       WHERE questionnaireID = ${questionnaireID};`;                        /* this variables will be in quitation through the front end implementation */

            query_3 = `SELECT q.qID, q.qtext, q.required, q.type \
                       FROM Question q 
                       WHERE q.questionnaireID = ${questionnaireID} \                       /* this variables will be in quitation through the front end implementation */
                       ORDER BY q.qID;`;         
            connection.query(query_1, function(err, result_1) {
                if(err) {
                    res.statusCode = 400;
                    res.statusMessage = "Bad Request";
                    console.log("Bad request given", err);
                    connection.release();
                    res.end();
                } else if (result_1.length == 0) {
                    res.statusCode = 402;
                    res.statusMessage = "No Data";
                    console.log("No Data for Questionnaire given");
                    connection.release();
                    res.end();
                } else {
                    connection.query(query_2, function(err, result_2) {
                        if(err) {
                            res.statusCode = 400;
                            res.statusMessage = "Bad Request";
                            console.log("Bad request given", err);
                            connection.release();
                            res.end();
                        } else {
                            connection.query(query_3, function(err, result_3) {
                                if(err) {
                                    res.statusCode = 400;
                                    res.statusMessage = "Bad Request";
                                    console.log("Bad request given", err);
                                    connection.release();
                                    res.end();
                                } else {
                                    res.statusCode = 200;
                                    res.statusMessage = "OK";
                
                                    let questions = result_3;
                
                                    let keywords = result_2.map(function(obj) { // isolate keywords
                                        return obj.word;
                                    });
                                    
                                    if (req.query.format === "csv") {
                                        const header = json2csv({"questionnaireID":result_1[0].questionnaireID,
                                                                 "questionnaireTitle":result_1[0].questionnaireTitle});
                                        const fields_2 = ["word"];
                                        const fields_3 = ["qID", "qtext", "required", "type"];
                                        const data = header + '\n' + json2csv(result_2, {fields_2}) + '\n' + json2csv(questions, {fields_3});
                                        console.log("csv returned for Questionnaire query", data);
                                        connection.release();
                                        res.send(data);
                                    } else { // when query is ommited json is returned
                
                                        const response = {
                                            "questionnaireID":result_1[0].questionnaireID,
                                            "questionnaireTitle":result_1[0].questionnaireTitle,
                                            "keywords":keywords,
                                            "questions":questions
                                        }	
                
                                        res.json(response);
                                        // By default, the character encoding for the response will be set to UTF-8.
                                        console.log("json object returned for Questionnaire query", response);
                                        connection.release();
                                        res.end();
                                    } 
                                }
                            });

                        }
                    });
                }
            });
		}
	});
});

module.exports = router;