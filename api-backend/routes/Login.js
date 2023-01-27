const path = require('path')
const express = require('express')
const router = express.Router();

router.get("/", function(req, res) {
	res.render(path.join(__dirname, '../..') + "/frontend/login.html", 
    function(err, html) {
        if (err) {
            console.log(err);
            return;
        }
        res.send(html);
        res.end();
    });
});

module.exports = router;
