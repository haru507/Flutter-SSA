import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_search_app/routes/routes.dart';
import 'package:store_search_app/top.dart';
import 'package:store_search_app/search.dart';
import 'package:store_search_app/history.dart';
import 'package:store_search_app/signs/signin.dart';
import 'package:store_search_app/signs/signup.dart';
import 'package:store_search_app/models/user_model.dart';
import 'package:store_search_app/models/search_model.dart';
import 'package:store_search_app/components/result.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create: (context) => UserModel()),
        ChangeNotifierProvider<SearchModel>(create: (context) => SearchModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: '飯サーチ',
      theme: _createTheme(),
      home: Top(),
      routes: {
        Routes.top: (context) => Top(),
        Routes.search: (context) => Search(),
        Routes.signup: (context) => Signup(),
        Routes.signin: (context) => Signin(),
        Routes.history: (context) => History(),
        Routes.result: (context) => Result(),
      },
    );
  }
}

ThemeData _createTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.purple[800],
    accentColor: Colors.pink[600],
    canvasColor: Color.fromRGBO(251, 228, 251, 1),
    fontFamily: 'Georgia',
  );
}