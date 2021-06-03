import 'package:flutter/material.dart';
import 'package:store_search_app/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:store_search_app/routes/routes.dart';

class SignOut extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    // TODO: implement build
    return ChangeNotifierProvider<UserModel>(
      create: (_) => UserModel(),
      child: Consumer<UserModel>(
        builder: (context, model, child){
          return ListTile(
            leading: Icon(IconData(0xe848, fontFamily: 'MaterialIcons')),
            title: Text('サインアウト'),
            onTap: () async {
              await user.signout();
              print(user.uid);
              Navigator.pushReplacementNamed(context, Routes.top);
            }
          );
        },
      )
    );
  }
}