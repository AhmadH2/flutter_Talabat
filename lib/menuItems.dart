import 'package:flutter/material.dart';
import 'package:restaurant/favoriteList.dart';

import 'db.dart';
import 'db.dart';
import 'dish.dart';
import 'package:restaurant/ordered.dart';

class MenuItemsList extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MenuItemsList> {
  List<Dish> orderedDishes = [];
  List<int> favoriteDishesIndeces = [];

  void _setFavorite(int index) {
    dishes[index].isFavorite = true;
  }

  void _order(int index) {
    this.orderedDishes.add(dishes[index]);
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
                    builder: (context) =>
                        OrderedList(orderedDishes: this.orderedDishes),
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
            child: ListView.builder(
              itemCount: dishes.length,
              itemBuilder: (BuildContext context, int index) {
                return MenuItem(
                  dish: dishes[index],
                  addToFavorite: () {
                    _setFavorite(index);
                  },
                  orderDish: () {
                    _order(index);
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
  final VoidCallback addToFavorite;

  MenuItem({@required this.dish, this.orderDish, this.addToFavorite});
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
                        // IconButton(
                        //     icon: Icon(
                        //       this.dish.isFavorite
                        //           ? Icons.star
                        //           : Icons.star_border,
                        //     ),
                        //     onPressed: addToFavorite),
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
                onPressed: orderDish,
                color: Colors.green,
                textColor: Colors.yellow,
              ),
              RaisedButton(
                child: Text('Add to Favorite'),
                onPressed: addToFavorite,
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
