var express = require('express');
const pool = require('../helpers/db');
var router = express.Router();

router.get('/', function (req, res, next) {
  // res.render('index', { title: 'Express' });
  pool.query('SELECT * FROM categories', (error, results) => {
    if (error) {
      throw error;
    }
    console.log(results.rows);
    res.status(200).json(results.rows);
  })

});

module.exports = router;
