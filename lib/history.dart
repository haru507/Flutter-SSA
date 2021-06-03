import 'package:flutter/material.dart';
import 'package:store_search_app/components/drawer.dart';
import 'package:store_search_app/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class History extends StatelessWidget {
  static const String routeName = "/history";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("お店履歴画面"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
              .collection('results')
              .where("uid", isEqualTo: user.uid)
              .snapshots(),
            builder: (context, snapshot) {
              // データが取得できた場合
              if (snapshot.hasData) {
                final List<DocumentSnapshot> documents = snapshot.data.documents;
                // 取得した投稿メッセージ一覧を元にリスト表示
                return ListView(
                  children: documents.map((document) {
                    return Card(
                      child: ListTile(
                        title: Text(document['name']),
                        subtitle: Text(document['genre']),
                      ),
                    );
                  }).toList(),
                );
              }
            // データが読込中の場合
            return Center(
              child: Text('読込中...'),
            );
          },
        ),
        drawer: createDrawer(context),
      ),
    );
  }
}