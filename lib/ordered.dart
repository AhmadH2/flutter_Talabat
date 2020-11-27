import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/restaurant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';
import 'dish.dart';
import 'dishItem.dart';
import 'favoriteList.dart';
import 'menuItemsModel.dart';
import 'package:http/http.dart' as http;

class OrderedList extends StatefulWidget {
  @override
  _OrderedState createState() => _OrderedState();
}

class _OrderedState extends State<OrderedList> {
  _OrderedState();

  double _calculate() {
    double total = 0;

    Provider.of<MenuItemsModel>(context, listen: false)
        .orderedDishes
        .forEach((element) {
      total += element.price;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[500],
          title: Text('Ordered List',
              style: TextStyle(fontSize: 19, color: Colors.black)),
          actions: [
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
            RaisedButton(
                color: Colors.yellow[800],
                hoverColor: Colors.yellow[500],
                splashColor: Colors.yellow[500],
                focusColor: Colors.yellow[400],
                child: Text(' Menu',
                    style: TextStyle(fontSize: 19, color: Colors.black)),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<MenuItemsModel>(builder: (context, menuI, child) {
                return ListView.builder(
                  itemCount: Provider.of<MenuItemsModel>(context, listen: false)
                      .getOrderedDihes()
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderedItem(
                      dish: Provider.of<MenuItemsModel>(context, listen: false)
                          .getOrderedDihes()[index],
                    );
                  },
                );
              }),
            ),
            Consumer<MenuItemsModel>(builder: (context, price, child) {
              return Container(
                margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
                height: 50,
                width: double.infinity,
                color: Colors.yellowAccent[200],
                child: Center(
                  child: Text('Total Price to Pay: ${_calculate()}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

// class OrderedItem extends StatefulWidget {
//   final Dish dish;
//   final int index;

//   const OrderedItem({Key key, this.dish, this.index}) : super(key: key);
//   @override
//   _OrderedItemState createState() => _OrderedItemState(this.dish, this.index);
// }

// class _OrderedItemState extends State<OrderedItem> {
//   Future<Restaurant> restaurant;
//   final Dish dish;
//   final int index;

//   Future<Restaurant> fetchRestaurant() async {
//     http.Response response =
//         await http.get('http://appback.ppu.edu/restaurants/${dish.rest_id}');
//     if (response.statusCode == 200) {
//       //success, parse json data
//       List jsonRestaurant = jsonDecode(response.body);
//       Restaurant restaurant = Restaurant.fromJson(jsonRestaurant[0]);
//       return restaurant;
//     } else {
//       throw Exception("Failed to load data");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     this.restaurant = fetchRestaurant();
//   }

//   _OrderedItemState(this.dish, this.index);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         DishItem(
//           title: dish.title,
//           image: dish.image,
//           rating: dish.rating,
//           description: dish.description,
//         ),
//         FutureBuilder(
//           future: this.restaurant,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               Restaurant rest = snapshot.data;
//               return Text(rest.name);
//             } else if (snapshot.hasError) {
//               return Text("error ${snapshot.error}");
//             }
//             return Center(child: CircularProgressIndicator());
//           },
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             RaisedButton(
//               child: Text('delete'),
//               color: Colors.red,
//               hoverColor: Colors.yellow[400],
//               splashColor: Colors.yellow[400],
//               focusColor: Colors.yellow[400],
//               textColor: Colors.white,
//               onPressed: () {
//                 Provider.of<MenuItemsModel>(context, listen: false)
//                     .unOrderDish(index);
//                 setState(() {});
//               },
//             ),
//             RaisedButton(
//               child: Text('Confirm'),
//               color: Colors.amber[900],
//               hoverColor: Colors.yellow[400],
//               splashColor: Colors.yellow[400],
//               focusColor: Colors.yellow[400],
//               textColor: Colors.white,
//               onPressed: () {
//                 print('confirmed successfully');
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

class OrderedItem extends StatelessWidget {
  final Dish dish;

  OrderedItem({@required this.dish});
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
          Text(
              '${Provider.of<MenuItemsModel>(context, listen: false).findRest(dish.rest_id)}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: Text('delete'),
                color: Colors.red,
                hoverColor: Colors.yellow[400],
                splashColor: Colors.yellow[400],
                focusColor: Colors.yellow[400],
                textColor: Colors.white,
                onPressed: () {
                  Provider.of<MenuItemsModel>(context, listen: false)
                      .unOrderDish(dish);
                },
              ),
              RaisedButton(
                child: Text('Confirm'),
                color: Colors.amber[900],
                hoverColor: Colors.yellow[400],
                splashColor: Colors.yellow[400],
                focusColor: Colors.yellow[400],
                textColor: Colors.white,
                onPressed: () {
                  print('confirmed successfully');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
