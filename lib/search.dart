import 'package:flutter/material.dart';
import 'components/drawer.dart';
import 'components/parameters.dart';
import 'package:geolocator/geolocator.dart';

class Search extends StatefulWidget{
  static const String routeName = "/search";
  @override
  _SearchState createState() => _SearchState();
}

// 位置情報を扱えるようにする
// 非同期通信処理を行えるようにする。
class _SearchState extends State<Search> {
  String _range = "1";
  String _genre = "";
  String _marketPrice = "";
  int _coupon = 2;

  Position position;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('検索画面'),
          centerTitle: true,
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
              DropdownButton(
                value: _range,
                onChanged: (newValue) {
                  setState(() {
                    _range = newValue;
                  });
                },
                items: Parameters.rangeMap.entries.map((e) {
                  return DropdownMenuItem<String>(
                    child: SizedBox(
                      child: Text(e.value),
                      width: 180.0,
                    ) ,
                    value: e.key,
                  );
                }).toList(),
              ),
              Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
              DropdownButton(
                value: _genre,
                onChanged: (newValue) {
                  setState(() {
                    _genre = newValue;
                  });
                },
                items: Parameters.genreMap.entries.map((e) {
                  return DropdownMenuItem<String>(
                    child: SizedBox(
                      child: Text(e.value),
                      width: 180.0,
                    ),
                    value: e.key,
                  );
                }).toList(),
              ),
              Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
              DropdownButton(
                value: _marketPrice,
                onChanged: (newValue) {
                  setState(() {
                    _marketPrice = newValue;
                  });
                },
                items: Parameters.marketPriceMap.entries.map((e) {
                  return DropdownMenuItem<String>(
                    child: SizedBox(
                      child: Text(e.value),
                      width: 180.0,
                    ),
                    value: e.key,
                  );
                }).toList(),
              ),
              Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
              DropdownButton(
                value: _coupon,
                onChanged: (newValue) {
                  setState(() {
                    _coupon = newValue;
                  });
                },
                items: Parameters.couponMap.entries.map((e) {
                  return DropdownMenuItem<int>(
                    child: SizedBox(
                      child: Text(e.value),
                      width: 180.0,
                    ),
                    value: e.key,
                  );
                }).toList(),
              ),
              Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
              
              // ボタンを定義する
              ElevatedButton(
                onPressed: (){
                  print(_range);
                  print(_genre);
                  print(_marketPrice);
                  print(_coupon);
                },
                child: Text('検索する')
              ),
            ],
          )
        ),
        drawer: createDrawer(context),
      ),
    );
  }
}