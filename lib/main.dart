import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/loadingMenus.dart';
import 'package:restaurant/menuItemsModel.dart';
import 'menuItems.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MenuItemsModel(),
        child: MaterialApp(
          title: 'Flutter Demo',
          home: LoadingMenus(),
        ));
  }
}
