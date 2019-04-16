const jwt = require('jsonwebtoken');
const DbPool = require('../db/db.pool');
const connectionString = require('../configs/database.config');
const pool = new DbPool(connectionString);

const appConfig = require('../configs/app.config');

const { jwtKey, tokenExpiry } = appConfig;

const authorize = (req, res, next) => {
  const {
    email,
    password
  } = req.body;
  pool.executeQuery(`exec authorizeUser
    @email='${email}',
    @password='${password}';`, (result) => {
      if (result && result.recordset && result.recordset[0]) {
        const token = jwt.sign(
          {userId: result.recordset[0].UserId}, 
          jwtKey, 
          {expiresIn: tokenExpiry}
        );
        res.send({token});
      } else {
        res.sendStatus(401);
      }
    }, next);
}

module.exports = {
  authorize
}