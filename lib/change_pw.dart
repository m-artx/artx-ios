import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'font_util.dart'; // font_util.dart를 임포트합니다.
import 'my_profile.dart';

class ChangePwPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      backgroundColor: Color.fromARGB(255, 23, 23, 23), // 배경색 변경
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '비밀번호 변경',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: getFontFamily('비밀번호 변경'), // 폰트 적용
                  ),
                ),
              ),
              SizedBox(height: 16),
              Divider(color: Colors.white),
              SizedBox(height: 16), // 검은색 가로줄
              _buildTextField('현재 비밀번호', true),
              _buildTextField('새로운 비밀번호', true),
              _buildTextField('새로운 비밀번호 확인', true),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)), // 버튼 크기 조정
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyProfilePage()));
                  },
                  child: Text(
                    '비밀번호 변경하기',
                    style: TextStyle(fontSize: 16, fontFamily: getFontFamily('비밀번호 변경하기')),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: getFontFamily(label))),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(fontFamily: getFontFamily(label)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          obscureText: isPassword,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
