const EmployeeModel = require('../models/employee.model');
const DbPool = require('../db/db.pool');
const connectionString = require('../configs/database.config');
const pool = new DbPool(connectionString);

const getEmployees = (req, res, next) => {
  pool.executeQuery('exec getEmployees', (result) => {
    res.send((result && result.recordset) 
      ? result.recordset.map((record) => new EmployeeModel(record))
      : [])
    }, next);
}

module.exports = {
  getEmployees
}