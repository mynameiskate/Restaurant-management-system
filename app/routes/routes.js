dishRoutes = require('./dish.routes.js');
imageRoutes = require('./image.routes.js');
userRoutes = require('./user.routes.js');

module.exports = {
  dishes: dishRoutes,
  images: imageRoutes,
  users: userRoutes
}