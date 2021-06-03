import 'package:flutter/material.dart';
import 'package:store_search_app/routes/routes.dart';

class Register extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
    leading: Icon(Icons.assignment_ind),
    title: Text('サインアップ'),
    onTap: () {
      Navigator.pushReplacementNamed(context, Routes.signup);
    }
  );
  }
}