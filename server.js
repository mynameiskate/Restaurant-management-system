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
});