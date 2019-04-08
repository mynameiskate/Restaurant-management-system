const DishModel = require('../models/dish.model');
const DbPool = require('../db/db.pool');
const connectionString = require('../configs/database.config');
const pool = new DbPool(connectionString);

const getDishes = (req, res, next) => {
  pool.executeQuery('exec getAvailableDishes', (result) => {
    res.send((result && result.recordset) 
      ? result.recordset.map((record) => new DishModel(record))
      : [])
    }, next);
}

const createDish = (req, res, next) => {
  const { 
    name,
    description,
    cost,
    weight,
    nutritionalValue,
    isAvailable,
    dishCategoryId 
  } = req.body;

  pool.executeQuery(`exec createDish 
    @name='${name}',
    @description='${description}',
    @cost=${cost},
    @weight=${weight},
    @nutritionalValue='${nutritionalValue}', 
    @isAvailable=${isAvailable}, 
    @dishCategoryId=${dishCategoryId};`,
    (result) => {
      res.send(result);
    }, next);
}

const updateDish = (req, res, next) => {
  const dishId = req.params.id;
  const {
    name,
    description,
    cost,
    weight,
    nutritionalValue,
    isAvailable,
    dishCategoryId
  } = req.body;

  pool.executeQuery(`exec updateDish 
    @dishId=${dishId},
    @name='${name}',
    @description='${description}',
    @cost=${cost},
    @weight=${weight},
    @nutritionalValue='${nutritionalValue}', 
    @isAvailable=${isAvailable}, 
    @dishCategoryId=${dishCategoryId};`,
  (result) => {
    res.status(200);
    res.send(result);
  }, next);
}

const deleteDish = (req, res, next) => {
  const dishId = req.params.id;

  pool.executeQuery(`exec deleteDish @dishId=${dishId}`, 
  () => {
    res.status(200);
    res.send();
  }, next);
}

const assignCookToDish = (req, res, next) => {
  const {
    cookId,
    dishId,
    orderId
  } = req.body;

  pool.executeQuery(`exec assignCookToDish
    @employeeId=${cookId},
    @dishId=${dishId}
    @orderId=${orderId};`,
  (result) => {
    res.status(200);
    res.send(result);
  }, next);
}

module.exports = {
  getDishes,
  createDish,
  updateDish,
  deleteDish,
  assignCookToDish
}