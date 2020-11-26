import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/favoriteList.dart';
import 'package:restaurant/menuItemsModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dish.dart';
import 'package:restaurant/ordered.dart';

class MenuItemsList extends StatefulWidget {
  // This widget is the root of your application.

  int id;
  MenuItemsList();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MenuItemsList> {
  List<Dish> orderedDishes = [];
  List<int> favoriteDishesIndeces = [];
  int id;

  _MyAppState();

  // Future<List<Dish>> futureDishes;

  // Future<List<Dish>> fetchMenuItems() async {
  //   final http.Response response =
  //       await http.get("https://api.androidhive.info/json/movies.json");

  //   if (response.statusCode == 200) {
  //     // success, parse json data
  //     List jsonArray = jsonDecode(response.body);
  //     List<Dish> dishes = jsonArray.map((x) => Dish.fromJson(x)).toList();
  //     return dishes;
  //   } else {
  //     throw Exception("Failed to load data");
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   this.futureDishes = fetchMenuItems();
  //   Provider.of<MenuItemsModel>(context, listen: false)
  //       // .setDishes(this.futureDishes);
  // }

  // void _setFavorite(int index) {
  //   Provider.of<MenuItemsModel>(context, listen: false).setFavorite(index);
  //   setState(() {});
  // }

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
        title: Text('Menu Items'),
      ),
      body: Column(
        children: [
          RaisedButton(
              child: Text('Go to ordered Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderedList(),
                  ),
                );
              }),
          RaisedButton(
              child: Text('Go to favorite Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteList(),
                  ),
                );
              }),
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
  // final VoidCallback addToFavorite;

  MenuItem({@required this.dish, this.orderDish});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/' + this.dish.image,
                width: 150,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.dish.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(this.dish.description),
                    Row(
                      children: [
                        Consumer<MenuItemsModel>(
                            builder: (context, dishes, child) {
                          return IconButton(
                              icon: Icon(
                                Provider.of<MenuItemsModel>(context,
                                            listen: false)
                                        .cheak(dish)
                                    ? Icons.star
                                    : Icons.star_border,
                              ),
                              onPressed: () {
                                Provider.of<MenuItemsModel>(context,
                                        listen: false)
                                    .setFavorite(dish);
                              });
                        }),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(this.dish.rating.toString()),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: Text('Order'),
                onPressed: () {
                  Provider.of<MenuItemsModel>(context, listen: false)
                      .orderDish(dish);
                },
                color: Colors.green,
                textColor: Colors.yellow,
              ),
              RaisedButton(
                child: Text('Add to Favorite'),
                onPressed: null,
                color: Colors.blue,
                textColor: Colors.yellow,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
