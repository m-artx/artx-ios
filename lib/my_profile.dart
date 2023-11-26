import 'package:artx_ios/main.dart';
import 'package:artx_ios/test.dart';
import 'package:flutter/material.dart';
import 'custom_app_bar.dart'; // 앱바를 위한 사용자 정의 위젯을 임포트합니다.
import 'side_menu.dart'; // 사이드 메뉴를 위한 사용자 정의 위젯을 임포트합니다.
import 'customer_service.dart';
import 'service/api_service.dart';
import 'service/users_model.dart';
import 'package:provider/provider.dart';
import 'font_util.dart'; // font_util.dart를 임포트합니다.

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      backgroundColor: Color.fromARGB(255, 23, 23, 23), // 배경색 변경
      body: FutureBuilder<Map<String, dynamic>>(
        future: productService.getMyPageInfo(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}", style: TextStyle(fontFamily: getFontFamily('Error'))));
          } else if (snapshot.hasData) {
            var userInfo = snapshot.data!;
            return Column(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(userInfo['userProfileImage']),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userInfo['userNickname'] + '님, 어서오세요',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: getFontFamily(userInfo['userNickname']),
                              ),
                            ),
                            Text(
                              userInfo['userIntroduction'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: getFontFamily(userInfo['userIntroduction']),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 21),
                Divider(color: Colors.white),
                const SizedBox(height: 16),
                // 각 버튼의 스타일 및 크기를 수정합니다.
                _buildButton(context, '개인정보 관리', customer_service()),
                const SizedBox(height: 16),
                _buildButton(context, '비밀번호 변경', TestPage()),
                const SizedBox(height: 16),
                _buildButton(context, '주문/배송정보', TestPage()),
                const SizedBox(height: 16),
                _buildButton(context, '배송지관리', TestPage()),
                const SizedBox(height: 16),
                _buildButton(context, '고객센터', customer_service()),
                const SizedBox(height: 16),
                _buildLogoutButton(context, productService),
                SizedBox(height: 16),
              ],
            );
          } else {
            return Center(child: Text("No user data available", style: TextStyle(fontFamily: getFontFamily('No user data available'))));
          }
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, [Widget? nextPage]) {
    return ElevatedButton(
      onPressed: nextPage != null ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage)) : null,
      child: Text(text, style: TextStyle(color: Colors.white, fontFamily: getFontFamily(text))),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: Colors.black,
        minimumSize: Size(350, 50), // 너비를 늘렸습니다.
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, ProductService productService) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await productService.logout();
          Provider.of<UsersModel>(context, listen: false).setToken('');
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainScreen()),
            (Route<dynamic> route) => false,
          );
        } catch (e) {
          print('로그아웃 에러: $e');
        }
      },
      child: Text('로그아웃', style: TextStyle(color: Colors.white, fontFamily: getFontFamily('로그아웃'))),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        primary: Colors.black,
        minimumSize: Size(350, 50), // 너비를 늘렸습니다.
      ),
    );
  }
}
