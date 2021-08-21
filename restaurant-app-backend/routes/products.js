var express = require('express');
const pool = require('../helpers/db');
var router = express.Router();

router.get('/', function (req, res, next) {
  var searchQuery = req.query.search ? req.query.search.toLowerCase() : '';
  var categoryIdQuery = req.query.category_id;

  var rootQuery = 'SELECT * FROM products ';
  const likeQuery = "WHERE LOWER(name) LIKE('%" + searchQuery + "%')"
  rootQuery = rootQuery + likeQuery;
  rootQuery = rootQuery + " AND (" + populateCategoryClause(categoryIdQuery) + ")";
  // rootQuery = rootQuery + populate
  console.log(rootQuery);
  console.log(populateCategoryClause(categoryIdQuery));

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
      res.status(200).json(results.rows[0]);
    } else {
      res.status(404).json({ "message": "Item is not found." });
    }
  })
});

function populateCategoryClause(categories) {

  if (categories && categories.length > 0) {
    var queryString = ""
    if (Array.isArray(categories)) {
      categories.forEach((item, index) => {
        if (index == 0) {
          queryString += "category_id=" + item;
        } else {
          queryString += " OR category_id=" + item;
        }
      });
      return queryString;
    } else {
      return "category_id=" + categories;
    }
  }
  return "1=1"
}

module.exports = router;
