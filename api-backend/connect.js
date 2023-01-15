const mysql = require('mysql2');

// create the connection to database
const pool = mysql.createPool({
  host: 'localhost',
  user: process.env.usernameMYSQL,
  password: process.env.passwordMYSQL,
  database: 'intelliqDB',
  multipleStatements: true
});

// // connect to database
// pool.getConnection(function(err, connection) {
//     // perform a query
//     connection.query('SHOW DATABASES;', function(err, results, fields) {
//         console.log(results); // results contains rows returned by server
//         console.log(fields); // fields contains extra meta data about results, if available
//     });
    
//     // close the connection
//     connection.release();
// });

module.exports = pool;