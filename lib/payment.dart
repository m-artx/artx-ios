import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'font_util.dart';
import 'service/api_service.dart';
import 'cart.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final ProductService _productService = ProductService();
  String username = ''; // 사용자 이름
  String phoneNumber = ''; // 사용자 전화번호
  String address = ''; // 사용자 주소
  String addressDetail = ''; // 상세 주소
  List<CartItem> cartItems = []; // 장바구니 목록

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _fetchCartItems();
  }

  void _fetchUserData() async {
    // 임시 사용자 ID, 실제 앱에서는 동적으로 관리해야 합니다.
    String userId = "63b1fdff-b1fb-4141-bb4c-5342a81bd7b0";

    try {
      var userDetails = await _productService.getUserDetails(userId);
      setState(() {
        username = userDetails['username'] ?? '';
        phoneNumber = userDetails['phoneNumber'] ?? '';
        address = userDetails['address'] ?? '';
        addressDetail = userDetails['addressDetail'] ?? '';
      });
    } catch (e) {
      print("사용자 데이터 로드 실패: $e");
    }
  }

  Future<void> _fetchCartItems() async {
    try {
      // 임시로 1번 카트 아이디 사용
      final response = await _productService.getCartDetails(1);
      final List<dynamic> cartData = response['cartItemDetails'];

      final List<CartItem> loadedCartItems = cartData.map((itemData) {
        return CartItem(
          productTitle: itemData['productTitle'] ?? '제품명 없음',
          price: itemData['productPrice'],
          quantity: itemData['cartProductQuantity'],
          image: itemData['productRepresentativeImage'],
          cartId: itemData['cartId'],
          productId: itemData['productId'],
        );
      }).toList();

      setState(() {
        cartItems = loadedCartItems;
      });
    } catch (error) {
      print('장바구니 정보 불러오기 실패: $error');
    }
  }

  void _createOrder() async {
  // 임시 주문 데이터 - 실제 앱에서는 사용자 입력을 통해 데이터를 받아야 합니다.
  String userId = "63b1fdff-b1fb-4141-bb4c-5342a81bd7b0";
  List<Map<String, dynamic>> orderDetails = [
    {"productId": 0, "productQuantity": 0},
    // 다른 상품들 추가 가능
  ];
  Map<String, dynamic> deliveryDetail = {
    "deliveryReceiver": username,
    "deliveryReceiverPhoneNumber": phoneNumber,
    "deliveryReceiverAddress": address,
    "deliveryReceiverAddressDetail": addressDetail,
  };

  try {
    var response = await _productService.createOrder(
      userId: userId,
      orderDetails: orderDetails,
      deliveryDetail: deliveryDetail,
    );
    print("주문 성공: $response");
    // 성공 처리 로직 (예: 결제 페이지로 이동)
  } catch (e) {
    print("주문 실패: $e");
    // 실패 처리 로직 (예: 에러 메시지 표시)
  }
}

String _selectedPaymentMethod = 'kakaoPay';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // 사용자 정의 앱바
      drawer: SideMenu(), // 사이드 메뉴
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      body: SingleChildScrollView(

      child: Column(
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
                    fontFamily: getFontFamily('주문고객')
                  ),
                ),
                Row(
                  // 이름과 전화번호를 가로로 배열
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // 텍스트 색상을 흰색으로 설정
                        fontFamily: getFontFamily(username)
                      ),
                    ),
                    SizedBox(width: 8), // 이름과 전화번호 사이 간격
                    Text(
                      phoneNumber, // 디비에서 받아오세요
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // 텍스트 색상을 흰색으로 설정
                        fontFamily: getFontFamily(phoneNumber)
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
                    fontFamily: getFontFamily('배송정보')
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
                  Text(username,
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily(username))),
                  SizedBox(height: 4),
                  Text(address,
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily(address))),
                  SizedBox(height: 4),
                  Text(addressDetail,
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily(addressDetail))),
                  SizedBox(height: 4),
                  Text(phoneNumber,
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily(phoneNumber))),
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
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily('이름'))),
                  SizedBox(height: 4),
                  ...cartItems
                        .map((item) => CartItemWidget(item: item, productService: _productService))
                        .toList(),
                ],
              ),
            ),
          ),
          //여기에 채현님이 작품들을 넣어주세요
          Divider(color: Colors.white), // 검은색 가로줄
          // 결제수단 섹션
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '결제수단',
        style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily('이름')),
      ),
      SizedBox(height: 4),
      ListTile(
        leading: Radio<String>(
          value: 'kakaoPay',
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
            });
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min, // Row의 크기를 최소화합니다.
          children: [
            Image.asset('assets/images/payment_icon_yellow_small.png'),
          ],
        ),
      ),
      // 기타 결제수단 추가 가능
    ],
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
                  Text('결제정보',
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily('이름'))),
                  SizedBox(height: 4),
                  Text('총 작품 금액                                       가격',
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily('이름'))),
                  SizedBox(height: 4),
                  Text('총 배송비                                           가격',
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily('이름'))),
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
                      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily('이름'))),
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
                    onPressed: _createOrder, // 여기에서 _createOrder 메소드를 호출합니다.
                    child: Text('결제하기'),
                  ),
                SizedBox(height: 50),
                ],
                
              ),
            ),
          ),
        ],
      ),
      )
      
    );
  }
}