import 'package:flutter/material.dart';
import 'package:store_search_app/routes/routes.dart';

class Signs extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
    leading: Icon(Icons.transfer_within_a_station),
    title: Text('サインイン'),
    onTap: () {
      Navigator.pushReplacementNamed(context, Routes.signin);
    }
  );
  }
}