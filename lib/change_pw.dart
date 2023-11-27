import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'font_util.dart'; // Ensure this is the correct path to font_util.dart
import 'my_profile.dart';

class ChangePwPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center( // Wrap the Column in a Center widget
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '비밀번호 초기화',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: getFontFamily('비밀번호 초기화'),
                  ),
                  textAlign: TextAlign.center,
                ),
                Divider(color: Colors.white),
                SizedBox(height: 30),
                Text(
                  '고객님의 메일로 비밀번호 변경 메일을 발송합니다',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: getFontFamily('비밀번호 변경 안내'),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        minimumSize: Size(140, 50),
                      ),
                      onPressed: () {
                        // 메일 발송 로직 구현
                      },
                      child: Text(
                        '메일발송',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: getFontFamily('메일발송'),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.white,
                        minimumSize: Size(140, 50),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyProfilePage()));
                      },
                      child: Text(
                        '취소하기',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: getFontFamily('취소하기'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  '이메일 변경을 원하시면 개인정보를 수정하여 주세요',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: getFontFamily('이메일 변경 안내'),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
