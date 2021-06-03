import 'package:flutter/material.dart';
import 'package:store_search_app/components/drawer.dart';

class Top extends StatelessWidget {
  static const String routeName = "/top";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("トップページ"),
          centerTitle: true,
        ),
        drawer: createDrawer(context),
      ),
    );
  }
}