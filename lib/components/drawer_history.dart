import 'package:flutter/material.dart';
import 'package:store_search_app/routes/routes.dart';

class DrawerHistroy extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
    leading: Icon(Icons.transfer_within_a_station),
    title: Text('履歴画面'),
    onTap: () {
      Navigator.pushReplacementNamed(context, Routes.history);
    }
  );
  }
}