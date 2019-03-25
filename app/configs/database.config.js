const databaseConfig = {
  server: 'KATES-DESKTOP', 
  // server: 'DESKTOP-380P92N\\SQLEXPRESS', 
  database: 'rsmdb',
  driver: 'msnodesqlv8',
  options: {
    trustedConnection: true
  }
}

module.exports = databaseConfig;