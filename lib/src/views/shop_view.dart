import 'package:flutter/material.dart';
import '../components/money_displayer.dart';
import '../components/stat_shop.dart';

class ShopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          MoneyDisplayer(),
          StatShop(),
        ],
      )
    );
  }
}
