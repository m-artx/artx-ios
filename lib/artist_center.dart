import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'font_util.dart'; // 폰트 유틸 임포트
import 'test.dart'; // Test 페이지 임포트

class ArtistProductList extends StatefulWidget {
  @override
  _ArtistProductListState createState() => _ArtistProductListState();
}

class _ArtistProductListState extends State<ArtistProductList> {
  @override
  Widget build(BuildContext context) {
    // 버튼 스타일 정의
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent, // 버튼 배경색 (투명)
      foregroundColor: Colors.white, // 텍스트 색상
      side: BorderSide(color: Colors.white, width: 0.1), // 테두리 색상 및 두께 조절
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0), // 직사각형 모양
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20), // 버튼 내부 패딩 조절
    );

    // 텍스트 스타일 정의
    TextStyle buttonTextStyle = TextStyle(
      fontSize: 17, // 텍스트 크기 조절 // 글씨 두께
      fontFamily: getFontFamily('텍스트'), // 폰트 적용
    );

    // 아이콘과 텍스트를 분리하여 배치할 위젯
    Widget buildButton(IconData icon, String label) {
      return ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestPage())); // TestPage로 이동
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 아이콘을 오른쪽 끝으로, 텍스트는 왼쪽 정렬
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(label, style: buttonTextStyle),
            ),
            Icon(icon, color: Colors.white), // 아이콘 색상 지정
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0), // 화면 양 끝에서 패딩
          child: Column(
            children: <Widget>[
              SizedBox(height: 20), // 첫 번째 버튼 전 간격
              buildButton(Icons.chevron_right, '판매 상품 목록'),
              SizedBox(height: 20), // 버튼 사이 간격
              buildButton(Icons.chevron_right, '문의 관리'),
              SizedBox(height: 20), // 버튼 사이 간격
              buildButton(Icons.chevron_right, '개인 커미션 관리'),
              SizedBox(height: 20), // 마지막 버튼 후 간격
            ],
          ),
        ),
      ),
    );
  }
}
