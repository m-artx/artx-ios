import 'package:flutter/material.dart';
import 'custom_app_bar.dart'; // 앱바를 위한 사용자 정의 위젯을 임포트합니다.
import 'side_menu.dart'; // 사이드 메뉴를 위한 사용자 정의 위젯을 임포트합니다.
import 'customer_service.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // 사용자 정의 앱바를 추가합니다.
      drawer: SideMenu(), // 사이드 메뉴를 추가합니다.
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          SizedBox(height: 30), // 상단 여백을 줍니다.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40, // 원하는 반지름 크기로 조절하세요.
                  backgroundImage:
                      NetworkImage('여기에 프로필 이미지 URL을 넣으세요'), // 프로필 사진 URL
                ),
                SizedBox(width: 10), // 사진과 텍스트 사이의 간격을 줍니다.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '(닉네임)님, 어서오세요', // 실제 닉네임을 넣어주세요.
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '한줄소개 내용~', // 실제 한 줄 소개 내용을 넣어주세요.
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 21),
          Divider(color: Colors.white), // 검은색 가로줄
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text('개인정보 관리',
                style: TextStyle(color: Colors.white)), // 텍스트 색상을 흰색으로 변경
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.black, // 배경색을 검정색으로 변경
              minimumSize: Size(200, 50), // 버튼 크기를 변경
            ),
          ),
          const SizedBox(height: 16), // 버튼 사이의 간격을 조절할 수 있습니다.
          ElevatedButton(
            onPressed: () {},
            child: Text('비밀번호 변경',
                style: TextStyle(color: Colors.white)), // 텍스트 색상을 흰색으로 변경
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.black, // 배경색을 검정색으로 변경
              minimumSize: Size(200, 50), // 버튼 크기를 변경
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text('주문/배송정보',
                style: TextStyle(color: Colors.white)), // 텍스트 색상을 흰색으로 변경
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.black, // 배경색을 검정색으로 변경
              minimumSize: Size(200, 50), // 버튼 크기를 변경
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text('배송지관리',
                style: TextStyle(color: Colors.white)), // 텍스트 색상을 흰색으로 변경
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.black, // 배경색을 검정색으로 변경
              minimumSize: Size(200, 50), // 버튼 크기를 변경
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => customer_service(),
                ),
              );
            },
            child: Text(
              '고객센터',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.black,
              minimumSize: Size(200, 50),
            ),
          ),

          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text('로그아웃',
                style: TextStyle(color: Colors.white)), // 텍스트 색상을 흰색으로 변경
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.black, // 배경색을 검정색으로 변경
              minimumSize: Size(200, 50), // 버튼 크기를 변경
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
