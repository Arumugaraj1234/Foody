class DishDetailsModel {
  int dishType;
  String dishId;
  String dishName;
  double dishPrice;
  double dishCalories;
  String dishDescription;
  String dishImageLink;
  bool isAddonAvailable;
  int addedCount;

  DishDetailsModel(
      {this.dishType,
      this.dishId,
      this.dishName,
      this.dishPrice,
      this.dishCalories,
      this.dishDescription,
      this.dishImageLink,
      this.isAddonAvailable,
      this.addedCount});

  double totalPrice() {
    return addedCount * dishPrice;
  }
}
