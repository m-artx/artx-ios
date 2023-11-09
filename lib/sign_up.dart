import 'package:flutter/material.dart';

class CombinedSignUpScreen extends StatefulWidget {
  const CombinedSignUpScreen({Key? key}) : super(key: key);

  @override
  _CombinedSignUpScreenState createState() => _CombinedSignUpScreenState();
}

class _CombinedSignUpScreenState extends State<CombinedSignUpScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
              TextField(
                decoration: InputDecoration(
                  labelText: '아이디',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: '이름',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: '닉네임',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: '이메일',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: '전화번호',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: '주소',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const Divider(color: Colors.black),
              CheckboxListTile(
                title: const Text('모두 동의합니다'),
                value: isAllAgreed,
                onChanged: _setAllAgreed,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              ...List<Widget>.generate(4, (index) {
                return CheckboxListTile(
                  title: Text([
                    '만 14세 이상입니다',
                    '이용약관 동의',
                    '개인정보수집 및 이용동의',
                    '이메일 수신여부(선택)'
                  ][index]),
                  value: isAgreed[index],
                  onChanged: (bool? value) {
                    _setItemAgreed(index, value);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 81, 149, 72),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  '회원가입',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
