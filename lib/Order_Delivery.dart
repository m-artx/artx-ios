import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'font_util.dart';

class Order_Delivery extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<Order_Delivery> {
  String username = '함채현';
  String phoneNumber = '010-1234-5678';
  String address = '서울시 은평구 응암2동';
  String addressDetail = '힐스테이트 101동 101호';
  String deliveryNumber = '대한통운 582465104596';

  List<CartItem> cartItems = [
    CartItem(
      productTitle: '소망',
      price: 45000,
      quantity: 2,
      image: 'assets/images/test.png',
    ),
    CartItem(
      productTitle: '마더',
      price: 45000,
      quantity: 1,
      image: 'assets/images/test2.png',
    ),
  ];

  int getTotalProductPrice() {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  final int deliveryFee = 5000;

  int getFinalPrice() {
    return getTotalProductPrice() + deliveryFee;
  }

  String _selectedPaymentMethod = 'kakaoPay';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('주문내역', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: getFontFamily('주문하기'))),
              ),
            ),
            Divider(color: Colors.white),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('주문고객', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: getFontFamily('주문고객'))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(username, style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily(username))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(phoneNumber, style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily(phoneNumber))),
            ),
            Divider(color: Colors.white),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('배송정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: getFontFamily('배송정보'))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(address, style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily(address))
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(addressDetail, style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily(addressDetail))),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('운송장 정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: getFontFamily('배송정보'))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(deliveryNumber, style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily(addressDetail))),
            ),
            Divider(color: Colors.white),
            // 주문 작품 정보
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cartItems.map((item) => ListTile(
                  leading: Image.asset(item.image ?? 'assets/images/default.png', width: 50, height: 50),
                  title: Text(item.productTitle ?? '제품명 없음', style: TextStyle(color: Colors.white, fontFamily: getFontFamily(item.productTitle ?? '제품명 없음'))),
                  subtitle: Text('${item.price}원 x ${item.quantity}', style: TextStyle(color: Colors.white, fontFamily: getFontFamily('가격 정보'))),
                )).toList(),
              ),
            ),
            Divider(color: Colors.white),
            // 결제 정보
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(' ', style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily(' '))),
                  Text('결제 정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: getFontFamily('결제 정보'))),
                  Text(' ', style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily(' '))),
                  Text('총 작품 금액: ${getTotalProductPrice()}원', style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily('총 작품 금액'))),
                  Text('배송비: ${deliveryFee}원', style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily('배송비'))),
                  Text('총 결제 금액: ${getFinalPrice()}원', style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily('총 결제 금액'))),
                  Text(' ', style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: getFontFamily(' '))),
                ],
              ),
            ),
            Divider(color: Colors.white),
            
          ],
        ),
      ),
    );
  }
}

class CartItem {
  String? productTitle;
  int price;
  int quantity;
  String? image;

  CartItem({
    this.productTitle,
    required this.price,
    required this.quantity,
    this.image,
  });
}
