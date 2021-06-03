import 'package:flutter/material.dart';
import 'package:store_search_app/components/drawer.dart';
import 'package:store_search_app/components/parameters.dart';
import 'package:store_search_app/routes/routes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';
import 'package:store_search_app/models/search_model.dart';

class Search extends StatelessWidget{
  static const String routeName = "/search";
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('検索画面'),
          centerTitle: true,
        ),
        body: Consumer<SearchModel>(
          builder: (context, model, child){
            return Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.read<SearchModel>().address == "" ? "＋ボタンを押してね！" : context.read<SearchModel>().address),
                  Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  DropdownButton(
                    value: context.read<SearchModel>().range,
                    onChanged: (newValue) {
                      context.read<SearchModel>().setRange(newValue);
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
                    value: context.read<SearchModel>().genre,
                    onChanged: (newValue) {
                      context.read<SearchModel>().setGenre(newValue);
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
                    value: context.read<SearchModel>().marketPrice,
                    onChanged: (newValue) {
                      context.read<SearchModel>().setMarketPrice(newValue);
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
                    value: context.read<SearchModel>().coupon,
                    onChanged: (newValue) {
                      context.read<SearchModel>().setCoupon(newValue);
                    },
                    items: Parameters.couponMap.entries.map((e) {
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
                  // ボタンを定義する
                  ElevatedButton(
                    onPressed: (){
                      // 位置情報と上記4つをCloudFunctionsに渡す。
                      context.read<SearchModel>().fetchStores();
                      Navigator.pushReplacementNamed(context, Routes.result);
                    },
                    child: Text('検索する')
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0, left: 250.0),
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () async {
                        // 現在地を取得
                        final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                        context.read<SearchModel>().setPosition(position);
                        // 取得した場所から住所を取得
                        final coordinates= new Coordinates(position.latitude, position.longitude);
                        var addresses= await Geocoder.local.findAddressesFromCoordinates(coordinates);
                        var first= addresses.first;
                        print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
                          final address = first.adminArea + " " + first.locality;
                          context.read<SearchModel>().setAddress(address);
                      },
                    ),
                  )
                ],
              ),
            );
          }
        ),
        drawer: createDrawer(context),
      ),
    );
  }
}