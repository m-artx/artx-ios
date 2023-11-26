import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'font_util.dart'; // font_util.dart를 임포트합니다.

class customer_service extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      backgroundColor: Color.fromARGB(255, 23, 23, 23), // 배경색 변경
      body: Column(
        children: [
          SizedBox(height: 21),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '고객센터',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: getFontFamily('고객센터'), // 폰트 적용
              ),
            ),
          ),
          SizedBox(height: 16),
          Divider(color: Colors.white), // 검은색 가로줄
          ..._buildButtons(),
        ],
      ),
    );
  }

  List<Widget> _buildButtons() {
    List<String> buttonTitles = [
      '공지사항', '자주하는 질문', '1:1 문의 내역', '작가문의 내역', '작가 전환 신청'
    ];

    return buttonTitles.map((title) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: _buildButton(title),
      );
    }).toList();
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () {}, // 여기에 버튼 기능을 추가할 수 있습니다.
      child: Text(text, style: TextStyle(color: Colors.white, fontFamily: getFontFamily(text))),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: Colors.black,
        minimumSize: Size(350, 50), // 버튼의 너비를 늘렸습니다.
      ),
    );
  }
}
