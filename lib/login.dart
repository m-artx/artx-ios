import 'package:flutter/material.dart';
import 'font_util.dart';
import 'test.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 150),
              Image.asset(
                'assets/images/IntroLogo.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 50),
              // 아이디 TextField
              TextField(
                decoration: InputDecoration(
                  hintText: '아이디',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey), // 여기서 테두리 색상을 변경합니다.
                  ),
                ),
                style: TextStyle(color: Colors.black, fontFamily: getFontFamily('아이디')),
              ),
              const SizedBox(height: 16),
              // 비밀번호 TextField
              TextField(
                decoration: InputDecoration(
                  hintText: '비밀번호',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey), // 여기서 테두리 색상을 변경합니다.
                  ),
                ),
                obscureText: true,
                style: TextStyle(color: Colors.black, fontFamily: getFontFamily('비밀번호')),
              ),
              const SizedBox(height: 24),
              // 로그인 버튼
Container(
  child: ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      minimumSize: MaterialStateProperty.all<Size>(Size(300, 45)), // 버튼 크기 조절
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // 모서리 둥글기 적용
        ),
      ),
    ),
    onPressed: () {
      // 로그인 기능 구현
    },
    child: Text(
      '로그인',
      style: TextStyle(color: Colors.black, fontFamily: getFontFamily('로그인')),
    ),
  ),
),


              SizedBox(height: 5), // 버튼 사이의 간격
              // 카카오 로그인 버튼
              TextButton(
                onPressed: () {
                  // 카카오 로그인 기능 구현
                },
                child: Image.asset(
                  'assets/images/kakao_login_medium_wide.png',
                ),
              ),
              SizedBox(height: 24),
              // 아이디 찾기 & 비밀번호 찾기
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 아이디 찾기
                  TextButton(
                    onPressed: () {
                      // 아이디 찾기 페이지로 이동
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage()));
                    },
                    child: Text(
                      '아이디 찾기',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(" | ", style: TextStyle(color: Colors.white, fontSize: 15)), // 구분 기호 추가
                  SizedBox(width: 8),
                  // 비밀번호 찾기
                  TextButton(
                    onPressed: () {
                      // 비밀번호 찾기 페이지로 이동
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage()));
                    },
                    child: Text(
                      '비밀번호 찾기',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(" | ", style: TextStyle(color: Colors.white, fontSize: 15)), // 구분 기호 추가
                  SizedBox(width: 8),
                  // 회원가입
                  TextButton(
                    onPressed: () {
                      // 회원가입 페이지로 이동
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage()));
                    },
                    child: Text(
                      '회원가입',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

