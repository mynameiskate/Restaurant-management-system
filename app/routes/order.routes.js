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

  if (!tableNum || !created || !guestName) {
    res.status(400);
    res.send({error: 'Table number, creation date, and name of guest should not be empty'});
    return;
  }
  
  if (!Number.isInteger(tableNum) || (parseInt(tableNum) < 0)) {
    res.status(400);
    res.send({error: 'Table number should be a positive integer number.'});
    return;
  }

  if (!dishes || !dishes.length) {
    res.status(400);
    res.send({error: 'Order should contain dishes.'});
    return;
  }

  pool.executeQuery(`exec createOrder 
    @table=${parseInt(tableNum)},
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

  if (!tableNum || !guestName || !waiterId || !statusId) {
    res.status(400);
    res.send({error: 'Table number, creation date, ID of waiter, status and name of guest should not be empty'});
  }
  
  if (!Number.isInteger(tableNum) || (parseInt(tableNum) < 0)) {
    res.status(400);
    res.send({error: 'Table number should be a positive integer number.'});
  }

  if (!Number.isInteger(waiterId) || (parseInt(waiterId) < 0)) {
    res.status(400);
    res.send({error: 'ID of waiter should be a positive integer number.'});
  }

  if (!Number.isInteger(statusId) || (parseInt(statusId) < 0)) {
    res.status(400);
    res.send({error: 'ID of status should be a positive integer number.'});
  }

  if (!dishes || !dishes.length) {
    res.status(400);
    res.send({error: 'Order should contain dishes.'});
  }

  pool.executeQuery(`exec updateOrder
    @orderId=${parseInt(orderId)},
    @table=${parseInt(tableNum)},
    @guestName='${guestName}',
    @waiterId=${parseInt(waiterId)},
    @statusId=${parseInt(statusId)};`,
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

const assignCookToDish = (req, res, next) => {
  let {
    cookId,
    dishId,
    orderId
  } = req.query;

  if (!cookId || !orderId || !dishId) {
    res.status(400);
    res.send({error: 'ID of cook, order and dish should not be empty.'});
  }

  if (!Number.isInteger(+cookId) || !Number.isInteger(+dishId) || !Number.isInteger(+orderId)) {
    res.status(400);
    res.send({error: 'ID of cook, dish and order should be integer values.'});
    return;
  }

  cookId = parseInt(req.query.cookId);
  dishId = parseInt(req.query.dishId);
  orderId = parseInt(req.query.orderId);

  if ((cookId < 0) || (dishId < 0) || (orderId < 0)) {
    res.status(400);
    res.send({error: 'ID of cook, dish and order should be positive integer values.'});
    return;
  }

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
  getOrders,
  getOrder,
  updateOrder,
  createOrder,
  assignCookToDish
}