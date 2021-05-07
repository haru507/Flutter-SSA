import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier{
  UserModel user;

  void setUser(UserModel newUser){
    this.user = newUser;
    notifyListeners();
  }
}