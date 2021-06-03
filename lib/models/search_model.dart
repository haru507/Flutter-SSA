import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_search_app/api.dart';

class SearchModel extends ChangeNotifier{
  Position position;
  String range = "1";
  String genre = "";
  String marketPrice = "";
  String coupon = "";

  // 登録用の配列
  List lists = [];

  String address = "";

  // APIキーについては、HotPepperAPIから取得してください。
  final String apiKey = Api.api;
  final Firestore resultStores = Firestore.instance;

  Future fetchStores() async {
    final response = await http.get(Uri.parse("http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=${apiKey}&lat=${position.latitude}&lng=${position.longitude}&range=${range}&ktai_coupon=${coupon}&genre=${genre}&budget=${marketPrice}&count=100&format=json"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      if(position.latitude != null && position.longitude != null){
        var decodedJson = json.decode(response.body);
        var rand = new math.Random();
        int num = rand.nextInt(decodedJson["results"]["shop"].length);
        var stores = decodedJson["results"]["shop"][num];
        lists = [];
        lists.add(stores["name"]);
        lists.add(stores["photo"]["mobile"]["l"]);
        lists.add(stores["genre"]["name"]);
        lists.add(stores["budget"]["name"]);
        lists.add(stores["close"]);
        notifyListeners();
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future addStores(String uid) async {
    if(uid != ""){
      await resultStores.collection('results').add(
      {
        'uid': uid,
        'name': lists[0],
        'image': lists[1],
        'genre': lists[2],
        'budget': lists[3],
        'close': lists[4],
        'lat': position.latitude,
        'lng': position.longitude,
        'createdAt': Timestamp.now(),
      },
    );
    }
    // GoogleMapを開く
  }

  void setAddress(String address){
    this.address = address;
    notifyListeners();
  }
  void setRange(String newValue){
    this.range = newValue;
    notifyListeners();
  }
  void setGenre(String newValue){
    this.genre = newValue;
    notifyListeners();
  }
  void setMarketPrice(String newValue){
    this.marketPrice = newValue;
    notifyListeners();
  }
  void setCoupon(String newValue){
    this.coupon = newValue;
    notifyListeners();
  }
  void setPosition(Position position){
    this.position = position;
    notifyListeners();
  }
}