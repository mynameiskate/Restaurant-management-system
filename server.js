const express = require('express');
const cors = require('cors');
const corsConfig = require('./app/configs/cors.config');
const routes = require('./app/routes/routes');
const bodyParser = require('body-parser');
const app = express();

app.use(cors(corsConfig));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.listen(8000, () => {
  console.log('starting server...');
});

// setting up routes
// dishes
app.get('/api/dishes', routes.dishes.getDishes);
app.post('/api/dishes', routes.dishes.createDish);
app.put('/api/dishes/:id', routes.dishes.updateDish);
app.get('/api/dishes/:id', routes.dishes.getDish);
app.delete('/api/dishes/:id', routes.dishes.deleteDish);

// images
app.get('/api/images/:id', routes.images.getImage);

// users
app.get('/api/employees', routes.users.getEmployees);

// categories
app.get('/api/categories', routes.categories.getCategories);

// orders
app.get('/api/orders/:id', routes.orders.getOrder);
app.get('/api/orders', routes.orders.getOrders);
app.post('/api/orders', routes.orders.createOrder);
app.put('/api/orders/:id', routes.orders.updateOrder);

// global error handler
app.use((err, req, res, next) => {
  if (!err) return next();

  // set locals
  res.locals.message = err.message;

  res.status(err.status || 500);
  res.send('Something went completely wrong :(');
});

// catch 404
app.use((req, res, next) => {
  res.status(404);
  res.send('Not Found');
});