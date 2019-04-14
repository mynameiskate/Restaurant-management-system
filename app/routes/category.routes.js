const CategoryModel = require('../models/category.model');
const DbPool = require('../db/db.pool');
const connectionString = require('../configs/database.config');
const pool = new DbPool(connectionString);

const getCategories = (req, res, next) => {
  pool.executeQuery('exec getCategories', (result) => {
    res.send((result && result.recordset) 
      ? result.recordset.map((record) => new CategoryModel(record))
      : [])
    }, next);
}

module.exports = {
  getCategories
}