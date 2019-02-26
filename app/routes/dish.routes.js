const DishModel = require('../models/dish.model');
const DbPool = require('../db/db.pool');
const connectionString = require('../configs/database.config');
const pool = new DbPool(connectionString);

const getDishes = (req, res) => {
  try {
    pool.executeQuery(`SELECT Name, ImageId, Cost, Weight, Description FROM Dish
      LEFT OUTER JOIN DishImage on Dish.DishId = DishImage.DishId`, (result) => {

      res.send((result && result.recordset) 
        ? result.recordset.map((record) => new DishModel(record))
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