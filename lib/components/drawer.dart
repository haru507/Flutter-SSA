import 'package:flutter/material.dart';
import 'package:store_search_app/routes/routes.dart';

Widget createDrawer (BuildContext context) {

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          color: Theme.of(context).canvasColor,
          child: DrawerHeader(
            child: Text(
              'メニュー',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.details),
          title: Text('トップページ'),
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.top);
          }
        ),
        ListTile(
          leading: Icon(Icons.saved_search),
          title: Text('検索画面'),
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.search);
          }
        ),
        ListTile(
          leading: Icon(Icons.assignment_ind),
          title: Text('サインアップ'),
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.signup);
          }
        ),
        ListTile(
          leading: Icon(Icons.transfer_within_a_station),
          title: Text('サインイン'),
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.signin);
          }
        ),
      ],
    ),
  );
}