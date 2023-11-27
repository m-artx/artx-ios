import 'package:flutter/material.dart';
import 'login.dart';
import 'sign_up.dart';
import 'main.dart';
import 'service/users_model.dart';
import 'package:provider/provider.dart';
import 'my_profile.dart';

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
          icon: Icon(Icons.person),
          onPressed: () {
            // 로그인 상태 확인
            if (Provider.of<UsersModel>(context, listen: false).isLoggedIn) {
              // 로그인 상태일 때 MyProfilePage로 이동
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfilePage()));
            } else {
              // 로그인 상태가 아닐 때 LoginPage로 이동
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            }
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
