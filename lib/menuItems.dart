import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/dishItem.dart';
import 'package:restaurant/favoriteList.dart';
import 'package:restaurant/menuItemsModel.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'dish.dart';
import 'package:restaurant/ordered.dart';

class MenuItemsList extends StatefulWidget {
  int id;
  MenuItemsList();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MenuItemsList> {
  List<Dish> orderedDishes = [];
  List<int> favoriteDishesIndices = [];
  int id;

  _MyAppState();

  void _order(int index) {
    this
        .orderedDishes
        .add(Provider.of<MenuItemsModel>(context, listen: false).dishes[index]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[500],
        title: Text(
          'Menu',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        actions: [
          RaisedButton(
              color: Colors.yellow[800],
              hoverColor: Colors.yellow[500],
              splashColor: Colors.yellow[500],
              focusColor: Colors.yellow[400],
              child: Row(
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 20,
                  ),
                  Text('OrderedPage',
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderedList(),
                  ),
                );
              }),
          RaisedButton(
              color: Colors.yellow[800],
              hoverColor: Colors.yellow[500],
              splashColor: Colors.yellow[500],
              focusColor: Colors.yellow[400],
              child: Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 20,
                  ),
                  Text(' FavoritePage',
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteList(),
                  ),
                );
              }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<MenuItemsModel>(
              builder: (context, mentuItems, child) {
                return ListView.builder(
                  itemCount: Provider.of<MenuItemsModel>(context, listen: false)
                      .dishes
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return MenuItem(
                      dish: Provider.of<MenuItemsModel>(context, listen: false)
                          .dishes[index],
                      orderDish: () {
                        _order(index);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Dish dish;
  final VoidCallback orderDish;

  MenuItem({@required this.dish, this.orderDish});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DishItem(
            title: dish.title,
            image: dish.image,
            rating: dish.rating,
            description: dish.description,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Consumer<MenuItemsModel>(builder: (context, dishes, child) {
                    return IconButton(
                        icon: Icon(
                          Provider.of<MenuItemsModel>(context, listen: false)
                                  .cheak(dish)
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        color: Colors.yellow[900],
                        splashColor: Colors.black,
                        highlightColor: Colors.yellow[900],
                        focusColor: Colors.red,
                        iconSize: 22,
                        onPressed: () {
                          Provider.of<MenuItemsModel>(context, listen: false)
                              .setFavorite(dish);
                        });
                  }),
                  Text(
                    'Add To Favourite',
                    style: TextStyle(fontSize: 16, color: Colors.yellow[900]),
                  ),
                ],
              ),
              RaisedButton(
                color: Colors.amber[900],
                textColor: Colors.white,
                hoverColor: Colors.yellow[400],
                splashColor: Colors.yellow[400],
                focusColor: Colors.yellow[400],
                child: Text('Order'),
                onPressed: () {
                  Provider.of<MenuItemsModel>(context, listen: false)
                      .orderDish(dish);
                  Toast.show('Ordered Successfuly', context, duration: 3);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
