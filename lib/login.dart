import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'font_util.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Text("test",
        style: TextStyle(
                          color: Colors.white,
                          fontFamily: getFontFamily("텍스트"), // 필요하다면 이 부분을 수정
                        ),)
      )
    );
}
}
