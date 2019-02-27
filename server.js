const express = require('express');
const cors = require('cors');
const corsConfig = require('./app/configs/cors.config');
const app = express();

app.use(cors(corsConfig));
app.listen(8000, () => {
  console.log('starting server...');
});

//mock data just in case db connection does not work
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

// app.get('/api/dishes', (req, res) => {
//   //TODO: refactor and move to separate class
//   const sql = require('mssql/msnodesqlv8');
//   const connectionString = require('./app/configs/database.config');
//   const pool = new sql.ConnectionPool(connectionString);
//   const DishModel = require('./app/models/dish.model');

//   pool.connect().then((err) => {
//     pool.request().query('SELECT * FROM Dish', (err, result) => {
//         res.send((result && result.recordset) 
//           ? result.recordset.map((record) => new DishModel(
//               record.Name,
//               record.Cost,
//               record.Weight,
//               record.Description
//             )
//           )
//           : []);
//       })
//   })
//   .catch((err) => {
//     console.log(err);
//   });
// });