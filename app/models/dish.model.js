class Dish {
  constructor(dishEntity) {
    this.name = dishEntity.Name;
    this.cost = dishEntity.Cost;
    this.weight = dishEntity.Weight;
    this.description = dishEntity.Description;
    this.imageId = dishEntity.ImageId;
    this.nutritionalValue = dishEntity.NutritionalValue;
  }
}

module.exports = Dish;