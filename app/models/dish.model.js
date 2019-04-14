class Dish {
  constructor(dishEntity) {
    this.id = dishEntity.DishId;
    this.name = dishEntity.Name;
    this.cost = dishEntity.Cost;
    this.weight = dishEntity.Weight;
    this.description = dishEntity.Description;
    this.imageId = dishEntity.ImageId;
    this.nutritionalValue = dishEntity.NutritionalValue;
    this.category = {
      id: dishEntity.CategoryId,
      name: dishEntity.CategoryName
    };
    this.isAvailable = dishEntity.IsAvailable;
  }
}

module.exports = Dish;