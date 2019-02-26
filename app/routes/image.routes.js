const DbPool = require('../db/db.pool');
const connectionString = require('../configs/database.config');
const pool = new DbPool(connectionString);
const fileConfig = require('../configs/filesrv.config');
const path = require('path');

const getImage = (req, res) => {
  try {
    const imageId = req.params.id;

    pool.executeQuery(`SELECT TOP 1 FilePath FROM Image
      WHERE ImageId = ${imageId}`, (result) => {

        if (result && result.recordset && result.recordset[0]) {
          res.sendFile(path.join(fileConfig.filePath, result.recordset[0].FilePath));
        } else {
          res.status(404);
          res.send('Image not found');
        }
    });
  } catch (error) {
      res.status(500);
      res.send('Something went totally wrong :(');
  }
}

module.exports = {
  getImage
}