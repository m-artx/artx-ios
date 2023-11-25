import 'package:artx_ios/main.dart';
import 'package:flutter/material.dart';
import 'custom_app_bar.dart'; // 앱바를 위한 사용자 정의 위젯을 임포트합니다.
import 'side_menu.dart'; // 사이드 메뉴를 위한 사용자 정의 위젯을 임포트합니다.
import 'customer_service.dart';
import 'service/api_service.dart';
import 'service/users_model.dart';
import 'package:provider/provider.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      backgroundColor: Colors.grey,
      body: FutureBuilder<Map<String, dynamic>>(
    future: productService.getMyPageInfo(context),
    builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
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
                              ),
                            ),
                            Text(
                              userInfo['userIntroduction'],
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
                  child: Text('로그아웃', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    primary: Colors.black,
                    minimumSize: Size(200, 50),
                  ),
                ),
                SizedBox(height: 16),
              ],
            );
          } else {
            return Center(child: Text("No user data available"));
          }
        },
      ),
    );
  }
}