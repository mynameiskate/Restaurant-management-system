const express = require('express');
const cors = require('cors');
const corsConfig = require('./app/configs/cors.config');
const routes = require('./app/routes/routes');
const app = express();

app.use(cors(corsConfig));
app.listen(8000, () => {
  console.log('starting server...');
});

//setting up routes
app.get('/api/dishes', routes.dishes.getDishes);
app.get('/api/images/:id', routes.images.getImage);


//mock data just in case db connection does not work
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