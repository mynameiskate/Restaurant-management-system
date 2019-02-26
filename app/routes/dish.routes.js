const DishModel = require('../models/dish.model');
const DbPool = require('../db/db.pool');
const connectionString = require('../configs/database.config');
const pool = new DbPool(connectionString);

const getDishes = (req, res) => {
  try {
    pool.executeQuery('SELECT * FROM Dish', (result) => {
      res.send((result && result.recordset) 
        ? result.recordset.map((record) => new DishModel(
            record.Name,
            record.Cost,
            record.Weight,
            record.Description)
          )
        : [])
    });
  } catch (error) {
      res.status(500);
      res.send('Something went totally wrong :(');
  }
}

module.exports = {
  getDishes
}