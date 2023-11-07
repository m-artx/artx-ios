import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'font_util.dart';

class CartPage extends StatefulWidget {


  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      appBar: CustomAppBar(),
      drawer: SideMenu(),
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
