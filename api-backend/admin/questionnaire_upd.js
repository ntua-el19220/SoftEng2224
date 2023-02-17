const express = require('express');
const router = express.Router();
const pool = require('../connect');
const fs = require('fs');

router.post('/',  function(req, res) {
    if (req.file) {
        fs.readFile(req.file.path, (err, data) => {
            if (err) {
                res.statusCode = 500;
                res.statusMessage = "Internal Server Error";
                console.log("Database Connection failed", err);
                connection.release();
                res.end();
            } else {
                const fileContents = data.toString();
                fs.unlink(req.file.path, (err) => { // delete file afterwards
                    if (err) throw err;
                    console.log(`${req.file.path} was deleted`);
                });
                pool.getConnection(function(err, connection) {
                    if(err) {
                        res.statusCode = 500;
                        res.statusMessage = "Internal Server Error";
                        console.log("Database Connection failed", err);
                        res.end();
                    } else {
                        const query = "call quest_upd" + `('${fileContents}');`;
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
                                console.log("Questionnaire Uploaded!");
                                connection.release();
                                res.end();
                            }
                        });
                    }
                });
            }
        });
    } else {
        res.statusCode = 400;
        res.statusMessage = "Bad Request";
        console.log("No file was uploaded");
        res.end();
    }
});

module.exports = router;