import 'package:flutter/material.dart';
import 'login.dart'; // 필요한 login.dart 페이지를 import
// import 'sing_up.dart';

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
      title: Image.asset(
        'assets/images/app_bar_logo.png',
        fit: BoxFit.cover,
        height: kToolbarHeight * 0.3,
      ),
      actions: [
        IconButton(  // person 아이콘에 IconButton을 사용합니다.
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),  // LoginPage로 이동하는 로직을 추가
            );
          },
        ),
        SizedBox(width: 20),
        /* IconButton(  // person 아이콘에 IconButton을 사용합니다.
          icon: Icon(Icons.notifications),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreenUI()),  // LoginPage로 이동하는 로직을 추가
            );
          },
        ),
        */
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
