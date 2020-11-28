import 'package:flutter/cupertino.dart';
import 'package:restaurant/restaurant.dart';
import 'dish.dart';

class MenuItemsModel extends ChangeNotifier {
  List<Dish> favoriteDishes = [];
  List<Dish> dishes = [];
  List<Dish> orderedDishes = [];
  List<Restaurant> restaurants = [];

  void setDishes(List<Dish> dish) {
    this.dishes = dish;
  }

  void setRestaurants(List<Restaurant> restaurants) {
    this.restaurants = restaurants;
  }

  bool cheakFavorite(Dish dish) {
    return this.favoriteDishes.indexOf(dish) != -1 ? true : false;
  }

  List<Dish> getFavoriteDishes() {
    return favoriteDishes;
  }

  List<Dish> getOrderedDihes() {
    return this.orderedDishes;
  }

  void orderDish(Dish dish) {
    orderedDishes.add(dish);
    notifyListeners();
  }

  void unOrderDish(Dish dish) {
    if (this.orderedDishes.indexOf(dish) != -1) {
      this.orderedDishes.remove(dish);
      notifyListeners();
    }
  }

  bool existInFavorite(Dish dish) {
    return favoriteDishes.indexOf(dish) != -1 ? true : false;
  }

  void setFavorite(Dish dish) {
    if (existInFavorite(dish)) {
      favoriteDishes.remove(dish);
    } else {
      favoriteDishes.add(dish);
    }
    notifyListeners();
  }

  void removeFromFavorite(Dish dish) {
    if (existInFavorite(dish)) {
      this.favoriteDishes.remove(dish);
    }
    notifyListeners();
  }

  String findRest(int restId) {
    String restName = 'Unknown Restaurant';
    for (int i = 0; i < restaurants.length; i++) {
      if (restaurants[i].id == restId) {
        restName = restaurants[i].name;
      }
    }
    return restName;
  }
}
