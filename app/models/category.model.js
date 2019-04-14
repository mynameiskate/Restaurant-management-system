class Category {
  constructor(categoryEntity) {
    this.id = categoryEntity.Id;
    this.name = categoryEntity.Name;
  }
}

module.exports = Category;