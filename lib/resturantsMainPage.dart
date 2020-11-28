import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/dishItem.dart';
import 'package:restaurant/favoriteList.dart';
import 'package:restaurant/loadingMenus.dart';
import 'package:restaurant/ordered.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'restaurant.dart';

class RestaurantMainPage extends StatefulWidget {
  final List<Restaurant> restaurants;
  RestaurantMainPage(this.restaurants);
  @override
  _RestaurantMainPageState createState() =>
      _RestaurantMainPageState(restaurants);
}

class _RestaurantMainPageState extends State<RestaurantMainPage> {
  List<Restaurant> restaurants = [];
  _RestaurantMainPageState(this.restaurants);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[500],
        title: Text(
          'Restaurant List',
          style: TextStyle(fontSize: 14, color: Colors.black),
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
                  Icons.favorite_border,
                  size: 20,
                ),
                Text(' Favourite List'),
              ],
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteList(),
                  ));
            },
          ),
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
                Text(' Ordered List'),
              ],
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderedList(),
                  ));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (BuildContext context, index) {
          return RestaurantItem(restaurants[index]);
        },
      ),
    );
  }
}

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantItem(this.restaurant);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            DishItem(
              title: restaurant.name,
              image: restaurant.image,
              rating: restaurant.rating.toDouble(),
              description: '',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                    color: Colors.yellow[600],
                    hoverColor: Colors.yellow[400],
                    splashColor: Colors.yellow[400],
                    focusColor: Colors.yellow[400],
                    child: Text('Show Menu Items'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoadingMenus(this.restaurant.id)));
                    }),
                RaisedButton(
                    color: Colors.yellow[800],
                    hoverColor: Colors.yellow[600],
                    splashColor: Colors.yellow[600],
                    focusColor: Colors.yellow[400],
                    child: Text('Rate'),
                    onPressed: () {
                      _showDialog(context);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AlertDialog(
                title: Text('Rate ${this.restaurant.name} Restaurant'),
                content: Column(
                  children: [
                    SmoothStarRating(
                        allowHalfRating: false,
                        onRated: (value) {},
                        starCount: 5,
                        rating: 0,
                        size: 24.0,
                        isReadOnly: false,
                        filledIconData: Icons.star,
                        defaultIconData: Icons.star_border,
                        color: Colors.yellowAccent[700],
                        borderColor: Colors.yellowAccent[700],
                        spacing: 0.0),
                    FlatButton(
                      child: Text('Close!'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
