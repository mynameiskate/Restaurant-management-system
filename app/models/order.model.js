const Status = require('./status.model');
const Dish = require('./dish.model');

class Order {
  constructor(orderEntity, dishes) {
    this.id = orderEntity.OrderId;
    this.tableNum = orderEntity.TableNo;
    this.created = orderEntity.Created;
    this.guestName = orderEntity.GuestName;
    this.waiterId = orderEntity.WaiterId;
    this.status = new Status(
      orderEntity.StatusId,
      orderEntity.Status
    )
    this.dishes = dishes
      ? dishes.map(entity => new Dish(entity))
      : [];
  }
}
  
module.exports = Order;