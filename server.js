const express = require('express');
const cors = require('cors')

const app = express();

const corsOptions = {
origin: 'http://localhost:4200',
optionsSuccessStatus: 200
}
app.use(cors(corsOptions));

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

app.get('/api/dishes', (req, res) => {

  //TODO: refactor and move to separate class
  const sql = require('mssql/msnodesqlv8');
  const connectionString = require('./app/configs/database.config');
  const pool = new sql.ConnectionPool(connectionString);
  const DishModel = require('./app/models/dish.model');

  pool.connect().then((err) => {
    pool.request().query('SELECT * FROM Dish', (err, result) => {
        res.send((result && result.recordset) 
          ? result.recordset.map((record) => new DishModel(
            record.Name,
            record.Cost,
            record.Weight,
            record.Description)
          )
          : []);
      })
  })
  .catch((err) => {
    console.log(err);
  });
});