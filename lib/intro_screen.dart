import 'package:flutter/material.dart';
import 'dart:async'; // Timer를 사용하기 위해 추가
import 'main.dart'; // MainScreen을 위해 추가

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 3초 후에 MainScreen으로 이동
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
    });

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      body: Center(
        child: Image.asset('assets/images/IntroLogo.png',
        width: 130,
        height: 130,
        ), // 로고
      ),
    );
  }
}
