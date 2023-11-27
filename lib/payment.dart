import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'font_util.dart';
import 'service/api_service.dart';
import 'cart.dart';
import 'payment_kakaopay.dart';
import 'package:provider/provider.dart';
import 'service/users_model.dart';


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

  // 총 작품 금액을 계산하는 함수
  int getTotalProductPrice() {
    return cartItems.fold(
        0, (total, item) => total + (item.price * item.quantity));
  }

  // 배송비 (고정 값)
  final int deliveryFee = 5000;

  // 최종 결제 금액을 계산하는 함수
  int getFinalPrice() {
    return getTotalProductPrice() + deliveryFee;
  }

  String userId = ''; // 현재 로그인한 사용자의 ID

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _fetchCartItems();
  }

  void _fetchUserData() async {
    try {
      final userModel = Provider.of<UsersModel>(context, listen: false);
      userId = userModel.userId; // 현재 로그인한 사용자의 ID를 저장합니다.
      var userDetails = await _productService.getUserDetails(userModel.token);
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
    final token = Provider.of<UsersModel>(context, listen: false).token;
        final response = await _productService.getCartDetails(token);

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
    // 현재 로그인한 사용자의 ID를 가져옵니다.
    final userId = Provider.of<UsersModel>(context, listen: false).userId;
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
        userId: userId, // 여기서 userId를 사용합니다.
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
                          fontFamily: getFontFamily('주문고객')),
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
                              fontFamily: getFontFamily(username)),
                        ),
                        SizedBox(width: 8), // 이름과 전화번호 사이 간격
                        Text(
                          phoneNumber, // 디비에서 받아오세요
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white, // 텍스트 색상을 흰색으로 설정
                              fontFamily: getFontFamily(phoneNumber)),
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
                          fontFamily: getFontFamily('배송정보')),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: getFontFamily(username))),
                      SizedBox(height: 4),
                      Text(address,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: getFontFamily(address))),
                      SizedBox(height: 4),
                      Text(addressDetail,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: getFontFamily(addressDetail))),
                      SizedBox(height: 4),
                      Text(phoneNumber,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: getFontFamily(phoneNumber))),
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
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: getFontFamily('이름'))),
                      SizedBox(height: 4),
                      ...cartItems
                          .map((item) => CartItemWidget(
                                item: item,
                                productService: _productService,
                                onQuantityChanged: () {},
                              ))
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
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: getFontFamily('이름')),
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
                          Image.asset(
                              'assets/images/payment_icon_yellow_small.png',
                              width: 70, // 원하는 너비 설정
                              height: 30 // 원하는 높이 설정
                              ),
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
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      SizedBox(height: 4),
                      Text('총 작품 금액: ${getTotalProductPrice()}원',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      SizedBox(height: 4),
                      Text('총 배송비: ${deliveryFee}원',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      SizedBox(height: 4),
                      Text('최종 결제 금액: ${getFinalPrice()}원',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.white), // 검은색 가로줄
              PaymentKakaoPay(),
            ],
          ),
        ));
  }
}

