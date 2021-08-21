var express = require('express');
const pool = require('../helpers/db');
var router = express.Router();

router.get('/', function (req, res, next) {
  var rootQuery = "SELECT c.*, p.name AS product_name, p.image_path, p.price, ct.name AS category_name FROM cart AS c INNER JOIN products p ON p.id=c.product_id INNER JOIN categories ct ON ct.id=p.category_id WHERE is_deleted=false";

  // Query
  pool.query(rootQuery, (error, results) => {
    if (error) {
      throw error;
    }
    res.status(200).json(results.rows);
  })
});

router.delete('/:id', function (req, res, next) {
  const id = req.params.id

  var rootQuery = 'UPDATE cart SET is_deleted=true WHERE id=' + id;

  // Query
  pool.query(rootQuery, (error, results) => {
    if (error) {
      throw error;
    }

    if (results.rowCount > 0) {
      res.status(200).json({ "message": "Item is deleted from cart!" });
    } else {
      res.status(404).json({ "message": "Item is not found." });
    }
  })
});

router.delete('/', function (req, res, next) {
  var rootQuery = 'UPDATE cart SET is_deleted=true';

  // Query
  pool.query(rootQuery, (error, results) => {
    if (error) {
      throw error;
    }

    if (results.rowCount > 0) {
      res.status(200).json({ "message": "Items is deleted from cart!" });
    } else {
      res.status(404).json({ "message": "Items is not found." });
    }
  })
});

router.post('/', function (req, res, next) {
  const { id, count } = req.body;
  var selectQuery = 'SELECT * FROM cart WHERE product_id=' + id;

  pool.query(selectQuery, (error, results) => {
    if (error) {
      throw error;
    }

    if (results.rowCount > 0) {
      // Update is_deleted and count
      var updateQuery = 'UPDATE cart SET is_deleted=false, count=' + count + ' WHERE product_id=' + id;
      pool.query(updateQuery, (updateError, updateResults) => {
        if (updateError) {
          res.status(404).json({ "message": "Cannot update!" });
        } else {
          res.status(200).json({ "message": "Cart is updated!" });
        }
      })
    } else {
      // Insert new row
      var insertQuery = 'iNSERT INTO cart (product_id, is_deleted, count) VALUES (' + id + ', false, ' + count + ')';
      pool.query(insertQuery, (insertError, insertResults) => {
        if (insertError) {
          res.status(404).json({ "message": "Cannot insert!" });
        } else {
          res.status(200).json({ "message": "Inserted!" });
        }
      })
    }
  })
});

module.exports = router;
