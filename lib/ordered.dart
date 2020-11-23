import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/main.dart';
import 'dish.dart';

class OrderedList extends StatefulWidget {
  final List<Dish> orderedDishes;
  OrderedList({this.orderedDishes}) : super();

  @override
  _OrderedState createState() => _OrderedState(this.orderedDishes);
}

class _OrderedState extends State<OrderedList> {
  List<Dish> orderedDishes;
  _OrderedState(this.orderedDishes);

  double _calculate() {
    double total = 0;
    for (int i = 0; i < orderedDishes.length; i++) {
      total += orderedDishes[i].price;
    }
    return total;
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
              child: ListView.builder(
                itemCount: orderedDishes.length,
                itemBuilder: (BuildContext context, int index) {
                  return MenuItem(
                    dish: orderedDishes[index],
                    deleteItem: () {
                      orderedDishes.removeAt(index);
                      setState(() {});
                    },
                  );
                },
              ),
            ),
            Container(
              height: 50,
              child: Text('Total Price to Pay: ${_calculate()}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
