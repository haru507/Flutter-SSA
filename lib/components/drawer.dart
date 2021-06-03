import 'package:flutter/material.dart';
import 'package:store_search_app/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:store_search_app/models/user_model.dart';
import 'package:store_search_app/components/signs.dart';
import 'package:store_search_app/components/drawer_history.dart';
import 'package:store_search_app/components/signout.dart';
import 'package:store_search_app/components/register.dart';

Widget createDrawer(BuildContext context) {

  final user = Provider.of<UserModel>(context);

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
        user.getUser() == ""
          ?
        Signs()
          :
        DrawerHistroy(),

        user.getUser() == ""
          ?
        Register()
          :
        SignOut(),
      ],
    ),
  );
}