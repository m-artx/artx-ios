import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';

class customer_service extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      backgroundColor: Colors.black,
      body: Center(
        child: Text('여기에 프로필 관련 내용을 배치하세요.'),
      ),
    );
  }
}
