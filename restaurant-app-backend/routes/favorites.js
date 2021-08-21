var express = require('express');
const pool = require('../helpers/db');
var router = express.Router();

router.get('/', function (req, res, next) {
  var rootQuery = 'SELECT * FROM products WHERE is_favorited=true';

  // Query
  pool.query(rootQuery, (error, results) => {
    if (error) {
      throw error;
    }
    res.status(200).json(results.rows);
  })
});

router.get('/:id', function (req, res, next) {
  const id = req.params.id;

  var rootQuery = 'SELECT * FROM products WHERE id=' + id;

  // Query
  pool.query(rootQuery, (error, results) => {
    if (error) {
      throw error;
    }
    
    if (results.rowCount > 0) {
      const product = results.rows[0];
      const isFavorited = product.is_favorited;
      const updateQuery = 'UPDATE products SET is_favorited=' + !isFavorited + ' WHERE id=' + id

      pool.query(updateQuery, (error, results) => {
        if (error) {
          res.status(404).json({ "message": "Favorites cannot changed!" });
          throw error;
        }
        res.status(200).json({ "message": "Favorite is changed!" });
      })
    } else {
      res.status(404).json({ "message": "Item is not found." });
    }
  })
});

module.exports = router;
