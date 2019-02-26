const express = require('express');
const cors = require('cors');
const corsConfig = require('./app/configs/cors.config');
const routes = require('./app/routes/routes');
const app = express();

app.use(cors(corsConfig));
app.listen(8000, () => {
  console.log('starting server...');
});

//mock data just in case db connection does not work
/*
app.route('/api/dishes').get((req, res) => {
res.send([{ 
  name: 'mushroom soup',
  description: 'award winning mouth-watering soup' 
},
  {
    name: 'chicken soup',
    description: 'the best chicken soup in town'
  }]
);
});*/

//setting up routes
app.get('/api/dishes', routes.dishes.getDishes);
app.get('/api/images/:id', routes.images.getImage);