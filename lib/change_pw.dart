import 'package:flutter/material.dart';
import 'custom_app_bar.dart'; // 앱바를 위한 사용자 정의 위젯을 임포트합니다.
import 'side_menu.dart'; // 사이드 메뉴를 위한 사용자 정의 위젯을 임포트합니다.

class change_pw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // 사용자 정의 앱바를 추가합니다.
      drawer: SideMenu(), // 사이드 메뉴를 추가합니다.
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          const SizedBox(height: 16), // 간격
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: '현재 비밀번호',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          const Divider(color: Colors.black),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: '새로운 비밀번호',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: '새로운 비밀번호 확인',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          const Divider(color: Colors.black),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(double.infinity, 30), // 부모의 너비만큼과 30의 높이
                      primary: Colors.white, // 버튼 배경색을 흰색으로 설정
                      onPrimary: Colors.black, // 글자 색상을 검정색으로 설정
                    ),
                    onPressed: () {
                      // 변경 로직을 여기에 구현해라 함채현개발자시여.
                    },
                    child: Text('비밀번호 변경하기'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
