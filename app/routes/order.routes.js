const DishModel = require('../models/dish.model');
const OrderModel = require('../models/order.model');
const DbPool = require('../db/db.pool');
const connectionString = require('../configs/database.config');
const pool = new DbPool(connectionString);

const getOrders = (req, res, next) => {
  pool.executeQuery('exec getOrders', (result) => {
    res.send((result && result.recordset) 
      ? result.recordset.map((record) => new OrderModel(record))
      : [])
    }, next);
}

const createOrder = (req, res, next) => {
  const { 
    tableNum,
    created,
    guestName
  } = req.body;

  pool.executeQuery(`exec createOrder 
    @table=${tableNum},
    @created=${created},
    @guestName='${guestName}';`,
    (result) => {
      res.send(result);
    }, next);
}

const addDishToOrder = (req, res, next) => {
  const {
    dishId,
    orderId
  } = req.body;

  pool.executeQuery(`exec addDishToOrder
    @dishId=${dishId},
    @orderId=${orderId};`,
  (result) => {
    res.status(200);
    res.send(result);
  }, next);
}

const assignWaiterToOrder = (req, res, next) => {
  const {
    waiterId,
    orderId
  } = req.body;

  pool.executeQuery(`exec assignWaiterToOrder
    @waiterId=${waiterId},
    @orderId=${orderId};`,
  (result) => {
    res.status(200);
    res.send(result);
  }, next);
}

module.exports = {
  getOrders,
  createOrder,
  assignWaiterToOrder
}