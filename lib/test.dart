import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'font_util.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 23, 23, 23),
        appBar: CustomAppBar(),
        drawer: SideMenu(),
        body: SingleChildScrollView(
            child: Text(
          "테스트 페이지 ",
          style: TextStyle(
            color: Colors.white,
            fontFamily: getFontFamily("텍스트"), // 필요하다면 이 부분을 수정
          ),
        )));
  }
}
