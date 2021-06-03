import 'package:flutter/material.dart';
import 'package:store_search_app/routes/routes.dart';
import 'package:store_search_app/models/signup_model.dart';
import 'package:provider/provider.dart';
import 'package:store_search_app/components/drawer.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signup extends StatelessWidget {
  static const String routeName = "/signup";
  bool _isFlag;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final usernameController = TextEditingController();

    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('サインアップ'),
        ),
        body: Consumer<SignUpModel>(
          builder: (context, model, child){
            return Form(
              key: _registerFormKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'email*',
                        hintText: 'e-mail@example.com'
                      ),
                      controller: emailController,
                      onSaved: (text) {
                        model.email = text;
                      },
                      validator: context.read<SignUpModel>().emailValidator
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'username*',
                        hintText: 'your name'
                      ),
                      controller: usernameController,
                      onSaved: (text) {
                        model.username = text;
                      },
                      validator: context.read<SignUpModel>().usernameValidator,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'password*',
                        hintText: 'password',
                        suffixIcon: IconButton(
                          icon: Icon(context.watch<SignUpModel>().showPassword // パスワード表示状態を監視(watch)
                              ? FontAwesomeIcons.solidEye
                              : FontAwesomeIcons.solidEyeSlash),
                          onPressed: () =>
                              context.read<SignUpModel>().togglePasswordVisible(), // パスワード表示・非表示をトグルする
                        ),
                      ),
                      obscureText: !context.watch<SignUpModel>().showPassword,
                      controller: passwordController,
                      validator: context.read<SignUpModel>().pwdValidator,
                      onSaved: (text) {
                        model.password = text;
                      },
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '既にアカウントを作成されている方は ',
                          ),
                          TextSpan(
                            text: 'こちら',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                            recognizer: new TapGestureRecognizer()..onTap = () {
                              Navigator.pushReplacementNamed(context, Routes.signin);
                            },
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      child: Text('登録する'),
                      onPressed: () async {
                        if(_registerFormKey.currentState.validate()){
                          try{
                            _registerFormKey.currentState.save();
                            await model.signUp();
                            _isFlag = true;
                            _showDialog(context, '登録完了。サインイン画面に遷移します。');
                            emailController.clear();
                            passwordController.clear();
                            usernameController.clear();
                          }catch(e){
                            _isFlag = false;
                            _showDialog(context, e.toString());
                          }
                        }
                    })
                  ],
                ),
              )
            );
          }),
          drawer: createDrawer(context),
      ),
    );
  }

  Future _showDialog(
    BuildContext context,
    String title,
  ){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            ElevatedButton(onPressed: () {
              if(_isFlag){
                Navigator.pushReplacementNamed(context, Routes.signin);
              }else{
                Navigator.pop(context);
              }
            },
            child: Text('OK'),
            )
          ],
        );
    });
  }
}