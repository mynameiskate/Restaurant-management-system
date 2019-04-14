dishRoutes = require('./dish.routes.js');
imageRoutes = require('./image.routes.js');
userRoutes = require('./user.routes.js');
orderRoutes = require('./order.routes.js');
categoryRoutes = require('./category.routes.js');

module.exports = {
  dishes: dishRoutes,
  images: imageRoutes,
  users: userRoutes,
  orders: orderRoutes,
  categories: categoryRoutes
}