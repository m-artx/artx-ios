import 'package:flutter/material.dart';

class PaymentKakaoPay extends StatefulWidget {
  @override
  _PaymentKakaoPayState createState() => _PaymentKakaoPayState();
}

class _PaymentKakaoPayState extends State<PaymentKakaoPay> {
  void _createOrder() {
    // 여기에 결제 생성 로직을 구현하세요.
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 30),
                primary: Colors.white,
                onPrimary: Colors.black,
              ),
              onPressed: _createOrder,
              child: Text('결제하기'),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
