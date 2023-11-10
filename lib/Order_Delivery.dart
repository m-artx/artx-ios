import 'package:flutter/material.dart';
import 'custom_app_bar.dart'; // 앱바를 위한 사용자 정의 위젯을 임포트합니다.
import 'side_menu.dart'; // 사이드 메뉴를 위한 사용자 정의 위젯을 임포트합니다.

class Order_Delivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // 사용자 정의 앱바를 추가합니다.
      drawer: SideMenu(), // 사이드 메뉴를 추가합니다.
      backgroundColor: Colors.black,
      body: Center(
        child: Text('여기에 프로필 관련 내용을 배치하세요.'),
      ),
    );
  }
}
