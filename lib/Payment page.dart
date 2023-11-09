import 'package:flutter/material.dart';
import 'custom_app_bar.dart'; // 앱바를 위한 사용자 정의 위젯
import 'side_menu.dart'; // 사이드 메뉴를 위한 사용자 정의 위젯

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // 사용자 정의 앱바
      drawer: SideMenu(), // 사이드 메뉴
      backgroundColor: Colors.black, // 전체 배경색을 검정색으로 설정

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // 주문고객과 이름 및 전화번호를 양 끝으로
              children: [
                Text(
                  '주문고객',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // 텍스트 색상을 흰색으로 설정
                  ),
                ),
                Row(
                  // 이름과 전화번호를 가로로 배열
                  children: [
                    Text(
                      '이름', // 디비에서 받아오세요
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // 텍스트 색상을 흰색으로 설정
                      ),
                    ),
                    SizedBox(width: 8), // 이름과 전화번호 사이 간격
                    Text(
                      '전화번호', // 디비에서 받아오세요
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // 텍스트 색상을 흰색으로 설정
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: Colors.white), // 흰새긔 가로줄
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '배송정보',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // 텍스트 색상을 흰색으로 설정
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black), // 네모칸 테두리 색상
                    borderRadius: BorderRadius.circular(4), // 네모칸의 둥근 모서리
                  ),
                  child: InkWell(
                    onTap: () {
                      // 배송지 변경 로직을 여기에 구현합니다.
                      print('배송지 변경 클릭');
                    },
                    child: Text('배송지 변경'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이름',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(height: 4),
                  Text('주소',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(height: 4),
                  Text('전화번호',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(height: 4),
                  // 다른 위젯들을 여기에 추가할 수 있습니다.
                ],
              ),
            ),
          ),

          Divider(color: Colors.white), // 검은색 가로줄
          // 여기에 추가적인 위젯들을 배치

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('주문 작품 정보',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ),
          //여기에 채현님이 작품들을 넣어주세요
          Divider(color: Colors.white), // 검은색 가로줄
          /* 지금부터는 결제 수단 */
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('결제수단',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ),
          // 여기에 카카오페이 토스페이 연결

          Divider(color: Colors.white), // 검은색 가로줄
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('결제정보',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(height: 4),
                  Text('총 작품 금액                                       가격',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(height: 4),
                  Text('총 배송비                                           가격',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ),
          Divider(color: Colors.white), // 검은색 가로줄
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('최종 결제 금액 가격',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(height: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(double.infinity, 30), // 부모의 너비만큼과 30의 높이
                      primary: Colors.white, // 버튼 배경색을 흰색으로 설정
                      onPrimary: Colors.black, // 글자 색상을 검정색으로 설정
                      // 버튼의 둥근 모서리를 원하시면 아래 코드를 추가하세요.
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(8.0),
                      // ),
                    ),
                    onPressed: () {
                      // 결제 로직을 여기에 구현합니다.
                    },
                    child: Text('(최종결제금액) 원 결제하기'),
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
