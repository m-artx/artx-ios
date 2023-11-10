import 'package:flutter/material.dart';
import 'login.dart'; // 필요한 login.dart 페이지를 import
import 'sign_up.dart';
import 'main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      centerTitle: true,
      title: GestureDetector(
        // GestureDetector로 로고를 감싸 클릭 이벤트를 처리합니다.
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => MainScreen()), // 메인 화면으로 이동합니다.
            (Route<dynamic> route) => false,
          );
        },
        child: Image.asset(
          'assets/images/app_bar_logo.png',
          fit: BoxFit.cover,
          height: kToolbarHeight * 0.3,
        ),
      ),
      actions: [
        IconButton(
          // person 아이콘에 IconButton을 사용합니다.
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPage()), // LoginPage로 이동하는 로직을 추가
            );
          },
        ),
        SizedBox(width: 20),
        IconButton(
          // person 아이콘에 IconButton을 사용합니다.
          icon: Icon(Icons.notifications),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SignupPage()), // LoginPage로 이동하는 로직을 추가
            );
          },
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
