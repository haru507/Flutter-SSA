import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInModel extends ChangeNotifier{
  String email = "";
  String password = "";
  String message = '';
  String uid = "";
  String username = "";
  bool showPassword = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn() async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    );
    this.uid = result.user.uid;
    DocumentSnapshot docSnapshot = await Firestore.instance.collection("users").document(uid).get();
    final user = docSnapshot.data;

    this.username = user['username'];

    notifyListeners();
  }

  void togglePasswordVisible() { //パスワード表示切り替え
    showPassword = !showPassword;
    notifyListeners();
  }

  String emailValidator(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if(value.isEmpty || value == null) {
      return 'e-mailアドレスを入力してください。';
    }
    else if (!regex.hasMatch(value)) {
      return '正しいEmailのフォーマットで入力してください';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'パスワードは8文字以上で入力してください';
    } else {
      return null;
    }
  }
}