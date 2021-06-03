import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultModel extends ChangeNotifier{
  // 取得用の配列
  List results = [];
  final Firestore resultStores = Firestore.instance;

  Future fetchResult(String uid) async {
    print("a");
    final docs = await resultStores.collection("results").where(uid, isEqualTo: uid).getDocuments();
    final results = docs.documents;
    print(results);
    notifyListeners();
  }
}