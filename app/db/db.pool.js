const sql = require('mssql/msnodesqlv8');

class DbPool {
  constructor(config) {
    this.poolPromise =  new sql.ConnectionPool(config)
      .connect()
      .then(pool => {
        console.log('connected to MSSQL')
        return pool;
      });
  }

  executeQuery(query, callback) {
    this.poolPromise.then((pool) => {
        pool.request().query(query, (err, result) => {
          if (err) {
            throw err;
          } else if (callback) {
            callback(result);
          }
        }
      );
    });
  }
}

module.exports = DbPool;

