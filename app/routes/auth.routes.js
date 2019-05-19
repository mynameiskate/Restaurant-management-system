const jwt = require('jsonwebtoken');
const DbPool = require('../db/db.pool');
const connectionString = require('../configs/database.config');
const pool = new DbPool(connectionString);

const appConfig = require('../configs/app.config');

const { jwtKey, tokenExpiry } = appConfig;

const authorize = (req, res, next) => {
  let {
    email,
    password
  } = req.body;

  if (!email || !password) {
    res.status(400);
    res.send({error: 'Email and password should be specified'});
    return;
  }

  if ((email.length < 3) || !email.includes('@')) {
    res.status(400);
    res.send({error: 'Provided email is not valid'});
    return;
  }

  if ((password.trim().length < 6) || (password.trim().length > 30)) {
    res.status(400);
    res.send({error: 'Password length should be from 6 to 30 characters.'});
    return;
  }

  pool.executeQuery(`exec authorizeUser
    @email='${email}',
    @password='${password}';`, (result) => {
      if (result && result.recordset && result.recordset[0]) {
        const token = jwt.sign(
          {userId: result.recordset[0].UserId}, 
          jwtKey, 
          {expiresIn: tokenExpiry}
        );
        res.status(200);
        res.send({token});
      } else {
        res.sendStatus(401);
        return;
      }
    });
}

module.exports = {
  authorize
}