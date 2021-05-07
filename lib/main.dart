import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'top.dart';
import 'search.dart';
import 'history.dart';
import 'signs/signin.dart';
import 'signs/signup.dart';
import 'models/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserModel user = UserModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '飯サーチ',
      theme: _createTheme(),
      home: Top(),
      routes: {
        Routes.top: (context) => Top(),
        Routes.search: (context) => Search(),
        Routes.signup: (context) => Signup(),
        Routes.signin: (context) => Signin(),
        Routes.history: (context) => History(),
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