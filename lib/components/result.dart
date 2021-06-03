import 'package:flutter/material.dart';
import 'package:store_search_app/components/drawer.dart';
import 'package:store_search_app/models/search_model.dart';
import 'package:store_search_app/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:store_search_app/routes/routes.dart';

class Result extends StatelessWidget {
  static const String routeName = "/result";

  @override
  Widget build(BuildContext context) {

    final search = Provider.of<SearchModel>(context);
    final user = Provider.of<UserModel>(context);

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("検索結果画面"),
          centerTitle: true,
        ),
        body: Consumer<SearchModel>(
          builder: (context, model, child){
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    search.lists[0],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  Center(
                    child: Image.network(search.lists[1]),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  Card(
                    child: ListTile(
                      title: Text("ジャンル"),
                      subtitle: Text(search.lists[2]),
                    )
                  ),
                  Card(
                    child: ListTile(
                      title: Text("予算"),
                      subtitle: Text(search.lists[3]),
                    )
                  ),
                  Card(
                    child: ListTile(
                      title: Text("定休日"),
                      subtitle: Text(search.lists[4]),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, Routes.search);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          elevation: 16,
                        ),
                        child: Text('戻る')
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await search.addStores(user.uid);

                        },
                        child: Text('ここへ行く')
                      ),
                    ]
                  ),
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