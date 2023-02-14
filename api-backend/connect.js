const mysql = require('mysql2');

// create the connection to database
const pool = mysql.createPool({
  host: 'localhost',
  user: process.env.usernameMYSQL,
  password: process.env.passwordMYSQL,
  database: 'intelliqDB',
  multipleStatements: true,
  dateStrings: true // <--- fix date formats
});

module.exports = pool;