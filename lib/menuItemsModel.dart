import 'package:flutter/cupertino.dart';
import 'dish.dart';

class MenuItemsModel extends ChangeNotifier {
  List<Dish> dishes = [
    new Dish('Tinder', 'description', 25.0, 'tinder.jpg', 8.4, false),
    new Dish('Shawerma', 'description', 15.0, 'tinder.jpg', 8.4, false),
    new Dish('Konafa', 'description', 35.0, 'tinder.jpg', 8.4, false),
    new Dish('Tinder', 'description', 35.0, 'tinder.jpg', 8.4, false),
  ];

  List<Dish> favoriteDishes = [];

  List<Dish> getFavoriteDishes() {
    favoriteDishes.clear();
    dishes.forEach((element) {
      if (element.isFavorite) {
        favoriteDishes.add(element);
      }
    });
    return favoriteDishes;
  }

  void setFavorite(Dish dish) {
    int index = this.dishes.indexOf(dish);
    dishes[index].isFavorite = !dishes[index].isFavorite;
    notifyListeners();
  }
}
