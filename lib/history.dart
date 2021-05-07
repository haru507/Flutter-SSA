import 'package:flutter/material.dart';
import 'components/drawer.dart';

class History extends StatelessWidget {
  static const String routeName = "/history";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("お店履歴画面"),
          centerTitle: true,
        ),
        drawer: createDrawer(context),
      ),
    );
  }
}