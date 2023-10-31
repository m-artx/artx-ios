import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      leading: Icon(Icons.menu),
      centerTitle: true,  // 앱바의 타이틀을 중앙에 배치
      title: Image.asset(
        'assets/images/app_bar_logo.png',
        fit: BoxFit.cover,
        height: kToolbarHeight * 0.3,  // 로고 이미지 높이를 줄임
      ),
      actions: [
        Icon(Icons.person),
        SizedBox(width: 20),
        Icon(Icons.notifications),
        SizedBox(width: 10),  // 알림 아이콘과 화면 끝 사이에 여백을 추가
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
