import 'package:flutter/material.dart';
import 'package:store_search_app/routes/routes.dart';
import '../models/signin_model.dart';
import 'package:provider/provider.dart';
import '../components/drawer.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signin extends StatelessWidget {
  static const String routeName = "/signin";
  bool _isFlag;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('サインイン'),
        ),
        body: Consumer<SignInModel>(
          builder: (context, model, child){
            return Form(
              key: _loginFormKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                      validator: context.read<SignInModel>().emailValidator,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'password*',
                        hintText: 'password',
                        suffixIcon: IconButton(
                        icon: Icon(context.watch<SignInModel>().showPassword // パスワード表示状態を監視(watch)
                          ? FontAwesomeIcons.solidEye
                          : FontAwesomeIcons.solidEyeSlash),
                        onPressed: () =>
                          context.read<SignInModel>().togglePasswordVisible(), // パスワード表示・非表示をトグルする
                        ),
                      ),
                      obscureText: !context.read<SignInModel>().showPassword,
                      controller: passwordController,
                      
                      onSaved: (text) {
                        model.password = text;
                      },
                      validator: context.read<SignInModel>().pwdValidator,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'アカウントをまだ作成されていない方は ',
                          ),
                          TextSpan(
                            text: 'こちら',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                            recognizer: new TapGestureRecognizer()..onTap = () {
                              Navigator.pushReplacementNamed(context, Routes.signup);
                            },
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      child: Text('ログイン'),
                      onPressed: () async {
                        if(_loginFormKey.currentState.validate()){
                          try{
                            _isFlag = true;
                            _loginFormKey.currentState.save();
                            await model.signIn();
                            _showDialog(context, 'ログイン成功。検索画面に遷移します。');
                            emailController.clear();
                            passwordController.clear();
                          }catch(e){
                            _isFlag = false;
                            _showDialog(context, e.toString());
                          }
                        }
                    })
                  ],
                ),  
              ),
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
                Navigator.pushReplacementNamed(context, Routes.search); 
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