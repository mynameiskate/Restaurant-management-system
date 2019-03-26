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
app.delete('/api/dishes/:id', routes.dishes.deleteDish);

// images
app.get('/api/images/:id', routes.images.getImage);

// users
app.get('/api/employees', routes.users.getEmployees);

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

// mock data just in case db connection does not work
/*
app.route('/api/dishes').get((req, res) => {
  res.send([{
    name: 'mushroom soup',
    description: 'Award winning mouth-watering soup.',
    cost: 10,
    weight: 300,
    nutritionalValue: 272,
    isAvaliable: true,
    image: './rms-frontend/src/asset/images/dishes/mushroom-soup.jpg'
  },
  {
    name: 'chicken soup',
    description: 'The best chicken soup in town.',
    cost: 10,
    weight: 300,
    nutritionalValue: 320,
    isAvaliable: true,
    image: './rms-frontend/src/asset/images/dishes/chicken-soup.jpg'
  },
  {
    name: 'tomato soup',
    description: 'The best chicken soup in town.',
    cost: 10,
    weight: 300,
    nutritionalValue: 400,
    isAvaliable: false,
    image: './rms-frontend/src/asset/images/dishes/tomato-soup.jpg'
  }]
);
});
*/