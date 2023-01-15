const express = require('express');
const router = express.Router();
const pool = require('../connect');

router.get('/', function(req, res) {
	pool.getConnection(function(err, connection) {
        const connectionString = `mysql://${connection.config.user}:${connection.config.password}@${connection.config.host}/${connection.config.database}`;
		if(err) {
            res.statusMessage = "Internal Server Error";
            res.status(500).json({status:"failed", "dbconnection":`${connectionString}`});
            console.log("Database Connection failed", err);
  		} else {
            res.statusMessage = "OK";
			res.status(200).json({status:"OK", "dbconnection":`${connectionString}`});
            console.log("Database Connection successful");
		}
        connection.release();
        res.end();
	});
});

module.exports = router;