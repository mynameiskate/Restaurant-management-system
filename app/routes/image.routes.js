const DbPool = require('../db/db.pool');
const connectionString = require('../configs/database.config');
const pool = new DbPool(connectionString);
const fileConfig = require('../configs/filesrv.config');
const path = require('path');

const getImage = (req, res, next) => {
  const imageId = req.params.id;
  pool.executeQuery(`exec getImagePath ${imageId}`, (result) => {
    if (result && result.recordset && result.recordset[0]) {
      res.sendFile(path.join(fileConfig.filePath, result.recordset[0].FilePath));
    } else {
      res.status(404);
      res.send('Image not found');
    }
  }, next);
}

module.exports = {
  getImage
}