const DishModel = require('../models/dish.model');
const DbPool = require('../db/db.pool');
const connectionString = require('../configs/database.config');
const pool = new DbPool(connectionString);

const getDishes = (req, res, next) => {
  pool.executeQuery('exec getAllDishes', (result) => {
    res.send((result && result.recordset) 
      ? result.recordset.map((record) => new DishModel(record))
      : [])
    }, next);
}

const getDish = (req, res, next) => {
  const dishId = req.params.id;
  pool.executeQuery(`exec getDish
    @dishId=${dishId}`, (result) => {
      if (result && result.recordset && result.recordset[0]) {
        pool.executeQuery(`exec getDish
          @dishId=${dishId}`, (dishes) => {
            res.status(200);
            res.send(new DishModel(result.recordset[0]));
          }
        )
      } else {
        res.status(404);
        res.send('Not Found');
      }
    }, next);
}

const createDish = (req, res, next) => {
  const { 
    name,
    description,
    nutritionalValue,
    isAvailable,
    category
  } = req.body;

  const cost = parseFloat(req.body.cost);
  const weight = parseFloat(req.body.weight);

  if (!name || !cost || !weight || !category) {
    res.status(400);
    res.send({error: 'Name, cost, weight, category of the dish should not be empty.'});
    return;
  }

  if (!Number.isInteger(category.id)) {
    res.status(400);
    res.send({error: 'Dish category id should be an integer value.'});
    return;
  }

  if ((cost < 0) || (weight < 0) || (category.id < 0)) {
    res.status(400);
    res.send({error: 'Cost, weight ID of category be positive integer values.'});
    return;
  }

  let dishId = 0;

  pool.executeQuery(`exec createDish 
    @name='${name}',
    @description='${description}',
    @cost=${cost},
    @weight=${weight},
    @nutritionalValue='${nutritionalValue}',
    @isAvailable=${isAvailable || 0},
    @dishId=${dishId},
    @dishCategoryId=${parseInt(category.id)};`,
    (result) => {
      res.sendStatus(200);
    }, () => {
      res.sendStatus(400);
    });
}

const updateDish = (req, res, next) => {
  const dishId = req.params.id;
  const {
    name,
    description,
    nutritionalValue,
    isAvailable,
    category
  } = req.body;

  const cost = parseFloat(req.body.cost);
  const weight = parseFloat(req.body.weight);

  if (!name || !cost || !weight || !category) {
    res.status(400);
    res.send({error: 'Name, cost, weight, category of the dish should not be empty.'});
    return;
  }

  if (!Number.isInteger(category.id)) {
    res.status(400);
    res.send({error: 'Dish category id should be an integer value.'});
    return;
  }

  if ((cost < 0) || (weight < 0) || (category.id < 0)) {
    res.status(400);
    res.send({error: 'Cost, weight ID of category be positive integer values.'});
    return;
  }

  pool.executeQuery(`exec updateDish 
    @dishId=${dishId},
    @name='${name}',
    @description='${description}',
    @cost=${cost},
    @weight=${weight},
    @nutritionalValue='${nutritionalValue}', 
    @isAvailable=${isAvailable}, 
    @dishCategoryId=${parseInt(category.id) || 0};`,
  (result) => {
    res.status(200);
    res.send();
  },
  () => {
    res.sendStatus(400);
  });
}

const deleteDish = (req, res, next) => {
  const dishId = req.params.id;

  pool.executeQuery(`exec deleteDish @dishId=${dishId}`, 
  (result) => {
    res.status(200);
    res.send();
  }, next);
}

module.exports = {
  getDishes,
  createDish,
  updateDish,
  deleteDish,
  getDish
}