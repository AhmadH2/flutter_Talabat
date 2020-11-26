import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/menuItemsModel.dart';
import 'db.dart';
import 'dish.dart';
import 'menuItems.dart';

class FavoriteList extends StatefulWidget {
  FavoriteList() : super();

  @override
  _FavoriteState createState() {
    return _FavoriteState();
  }
}

class _FavoriteState extends State<FavoriteList> {
  // List<Dish> favoriteDishes;

  _FavoriteState() {}

  void removeFromFavorite(index) {
    Provider.of<MenuItemsModel>(context, listen: false).setFavorite(
        Provider.of<MenuItemsModel>(context, listen: false)
            .getFavoriteDishes()[index]);
    // this.favoriteDishes.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Menu Items')),
        body: Column(
          children: [
            RaisedButton(
                child: Text('Go to Menu Page'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child: Consumer<MenuItemsModel>(
                  builder: (context, mentuItems, child) {
                return ListView.builder(
                    itemCount:
                        Provider.of<MenuItemsModel>(context, listen: false)
                            .getFavoriteDishes()
                            .length,
                    itemBuilder: (BuildContext context, int index) {
                      return MenuItem(
                        dish:
                            Provider.of<MenuItemsModel>(context, listen: false)
                                .getFavoriteDishes()[index],
                        deleteItem: () {
                          removeFromFavorite(index);
                        },
                      );
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Dish dish;
  final VoidCallback deleteItem;

  MenuItem({@required this.dish, @required this.deleteItem});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/' + this.dish.image,
                width: 100,
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
                        IconButton(
                            icon: Icon(
                              this.dish.isFavorite
                                  ? Icons.star
                                  : Icons.star_border,
                            ),
                            onPressed: null),
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
                child: Text('delete'),
                color: Colors.red,
                textColor: Colors.white,
                onPressed: deleteItem,
              ),
              RaisedButton(
                child: Text('Confirm'),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  print('confirmed successfullly');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
