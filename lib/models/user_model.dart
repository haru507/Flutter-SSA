import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends ChangeNotifier{
  // FirebaseUser user;
  String uid = "";
  String username = "";

  void setUser(String uid, String username){
    this.uid = uid;
    this.username = username;
    notifyListeners();
  }

  String getUser(){
    return this.uid;
  }

  Future signout() {
    FirebaseAuth.instance.signOut();
    this.uid = "";
    this.username = "";
    print(uid);
    notifyListeners();
  }
}