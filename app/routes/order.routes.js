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

const getOrder = (req, res, next) => {
  const orderId = req.params.id;
  pool.executeQuery(`exec getOrder
    @orderId=${orderId}`, (result) => {
      if (result && result.recordset && result.recordset[0]) {
        pool.executeQuery(`exec getOrderDishes
          @orderId=${orderId}`, (dishes) => {
            res.status(200);
            res.send(new OrderModel(result.recordset[0], dishes.recordset));
          }
        )
      } else {
        res.status(404);
        res.send('Not Found');
      }
    }, next);
}

const createOrder = (req, res, next) => {
  const { 
    tableNum,
    created,
    guestName,
    dishes
  } = req.body;

  pool.executeQuery(`exec createOrder 
    @table=${tableNum},
    @created=${created},
    @guestName='${guestName}';`,
  (orderId) => {
      updateOrderDishes(orderId, dishes);
      res.status(200);
      res.send(orderId);
    }, next);
}

const updateOrder = (req, res, next) => {
  const orderId = req.params.id;
  const {
    tableNum,
    guestName,
    waiterId,
    statusId,
    dishes
  } = req.body;

  pool.executeQuery(`exec updateOrder
    @orderId=${orderId},
    @table=${tableNum},
    @guestName='${guestName}',
    @waiterId=${waiterId},
    @statusId=${statusId};`,
  () => {
      updateOrderDishes(orderId, dishes);
      res.status(200);
      res.send();
  }, next);
}

const updateOrderDishes = (orderId, dishes) => {
  if (!dishes || !orderId) return;

  dishes.forEach(dish => {
    pool.executeQuery(`exec addDishToOrder
      @orderId=${orderId},
      @dishId=${dish.id},
      @count=${dish.count};`);
  });
}

module.exports = {
  getOrders,
  getOrder,
  updateOrder,
  createOrder
}