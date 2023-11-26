import 'package:flutter/material.dart';
import 'font_util.dart'; // font_util.dart를 임포트합니다.

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isAllAgreed = false;
  List<bool> isAgreed = [false, false, false, false];

  void _setAllAgreed(bool? value) {
    setState(() {
      isAllAgreed = value!;
      for (int i = 0; i < isAgreed.length; i++) {
        isAgreed[i] = isAllAgreed;
      }
    });
  }

  void _setItemAgreed(int index, bool? value) {
    setState(() {
      isAgreed[index] = value!;
      isAllAgreed = isAgreed.every((element) => element);
    });
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      hintText: label,
      hintStyle: TextStyle(fontFamily: getFontFamily(label)), // 폰트 적용
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      fillColor: Colors.white,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
  }

  Widget _buildTextField(String label, [bool showLabel = true, bool isPassword = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) 
          Text(label, style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: getFontFamily(label))),
        if (showLabel) SizedBox(height: 8),
        TextField(
          decoration: _buildInputDecoration(label),
          obscureText: isPassword,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildAddressField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('주소', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: getFontFamily('주소'))),
      SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: TextField(
              decoration: _buildInputDecoration('주소'),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              minimumSize: Size(100, 58), // 버튼의 높이를 입력 필드와 일치시킵니다.
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // 모서리 둥글기
              ),
              textStyle: TextStyle(
                fontFamily: getFontFamily('찾기'), // 폰트 적용
                fontSize: 18, // 폰트 크기
              ),
            ),
            child: Text('찾기'),
          ),
        ],
      ),
      SizedBox(height: 16),
    ],
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset(
                    'assets/images/IntroLogo.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),

              _buildTextField('아이디'),
              _buildTextField('비밀번호', true, true),
              _buildTextField('비밀번호 확인', false, true),
              _buildTextField('이름', true),
              _buildTextField('닉네임', true),
              _buildTextField('이메일', true),
              _buildTextField('전화번호', true),
              _buildAddressField(),
              _buildTextField('상세주소', false),
              const Divider(color: Colors.white),
              Theme(
                data: ThemeData(unselectedWidgetColor: Colors.white),
                child: CheckboxListTile(
                  title: Text('모두 동의합니다', style: TextStyle(color: Colors.white, fontFamily: getFontFamily('모두 동의합니다'))),
                  value: isAllAgreed,
                  onChanged: _setAllAgreed,
                  controlAffinity: ListTileControlAffinity.leading,
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                ),
              ),
              ...List<Widget>.generate(4, (index) {
                return Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: CheckboxListTile(
                    title: Text(
                      ['만 14세 이상입니다', '이용약관 동의', '개인정보수집 및 이용동의', '이메일 수신여부(선택)'][index],
                      style: TextStyle(color: Colors.white, fontFamily: getFontFamily(['만 14세 이상입니다', '이용약관 동의', '개인정보수집 및 이용동의', '이메일 수신여부(선택)'][index])),
                    ),
                    value: isAgreed[index],
                    onChanged: (bool? value) {
                      _setItemAgreed(index, value);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                  ),
                );
              }),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'ARTX 입장하기',
                    style: TextStyle(fontSize: 18, fontFamily: getFontFamily('회원가입')),
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
}
