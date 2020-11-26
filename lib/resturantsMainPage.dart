import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:talabat_application/menueItemsPage.dart';
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
        title: Text('Restaurant List'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (BuildContext context, index) {
          return RestaurantItem(
            restaurants[index].restaurantName,
            restaurants[index].city,
            restaurants[index].rating,
            restaurants[index].image,
            restaurants[index].id,
          );
        },
      ),
    );
  }
}

class RestaurantItem extends StatelessWidget {
  final String restaurantName;
  final String city;
  final int rating;
  final String image;
  final int id;
  RestaurantItem(
      this.restaurantName, this.city, this.rating, this.image, this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Image(image: NetworkImage('$image')),
                Column(
                  children: [
                    Text(this.restaurantName),
                    Text(this.city),
                    SmoothStarRating(
                        allowHalfRating: false,
                        onRated: (v) {},
                        starCount: 10,
                        rating: double.parse('${this.rating}'),
                        size: 24.0,
                        isReadOnly: false,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        color: Colors.yellow,
                        borderColor: Colors.yellow,
                        spacing: 0.0)
                  ],
                )
              ],
            ),
            Row(
              children: [
                RaisedButton(
                    child: Text('Show Menu Items'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuItems(this.id)));
                    }),
                RaisedButton(
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
        return AlertDialog(
          title: Text('Rate ${this.restaurantName} Restaurant'),
          content: Column(
            children: [
              SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {},
                  starCount: 10,
                  rating: 0,
                  size: 24.0,
                  isReadOnly: false,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  color: Colors.yellow,
                  borderColor: Colors.yellow,
                  spacing: 0.0),
              FlatButton(
                child: Text('Close me!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          actions: [],
        );
      },
    );
  }
}
