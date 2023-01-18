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
            query = `SELECT q.questionnaireID, q.qID, q.qtext, \
                    q.required, q.type, o.optID, o.opttxt, o.nextqID \
                    FROM Question q INNER JOIN \`Option\` o on o.qID = q.qID \
                    WHERE q.questionnaireID = '${questionnaireID}' AND q.qID = '${questionID}' \
                    ORDER BY o.optID;`;
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
                    console.log("No Data for Questions of the given questionnaire");
                    connection.release();
                    res.end();
                } else {

                    res.statusCode = 200;
                    res.statusMessage = "OK";

                    let options = result.map(function(obj) { // isolate options
                        let newObj = Object.assign({}, obj);
                        delete newObj.questionnaireID;
                        delete newObj.qID;
                        delete newObj.qtext;
                        delete newObj.required;
                        delete newObj.type;
                        return newObj;
                    });

                    if (req.query.format === "csv") {
                        const header = json2csv({"questionnaireID":result[0].questionnaireID,
                                                 "qID":result[0].qID,
                                                 "qtext":result[0].qtext,
                                                 "required":result[0].required,
                                                 "type":result[0].type});
                        const fields = ["optID", "opttxt", "nextqID"];
                        const data = header + '\n' + json2csv(options, {fields});
                        console.log("csv returned for Questions of Questionnaire query", data);
                        connection.release();
                        res.send(data);
                    } else { // when query is ommited json is returned

                        const response = {
                            "questionnaireID":result[0].questionnaireID,
                            "qID":result[0].qID,
                            "qtext":result[0].qtext,
                            "required":result[0].required,
                            "type":result[0].type,
                            "options":options
                        }	

                        res.json(response);
                        // By default, the character encoding for the response will be set to UTF-8.
                        console.log("json object returned for Questions of Questionnaire query", response);
                        connection.release();
                        res.end();
                    } 
                }
            });
		}
	});
});

module.exports = router;