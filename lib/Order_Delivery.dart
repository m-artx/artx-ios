import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'test.dart';

class Order_Delivery extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      'date': '2023-06-01',
      'amount': '10000',
      'image': 'assets/images/product1.jpeg', // 이미지 주석 해제
      'title': '상품 1'
    },
    {
      'date': '2023-05-30',
      'amount': '20000',
      // 'image': 'assets/images/product2.jpeg', // 이미지 주석 해제
      'title': '상품 2'
    },
    // 추가적인 주문 데이터...
  ];

  @override
  Widget build(BuildContext context) {
    // 날짜순으로 오름차순 정렬 아래 주석 없애세오
    // orders.sort((a, b) => a['date'].compareTo(b['date']));

    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      backgroundColor: Colors.grey,
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          var order = orders[index];
          return Container(
            margin: EdgeInsets.all(10), // Adjust the margin as needed
            decoration: BoxDecoration(
              color: Colors.white, // White color background
              border: Border.all(color: Colors.white), // White border
              borderRadius: BorderRadius.circular(10), // Rounded corners
              boxShadow: [
                // Optional: Add shadow for some depth effect
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              /*leading: Image.asset(order['image'],
                  width: 50, height: 50), // Image uncommented
              title:
                  Text(order['title'], style: TextStyle(color: Colors.black)),
              subtitle: Text(
                '₩${order['amount']} - ${order['date']}',
                style: TextStyle(color: Colors.black),
              ),*/

              onTap: () {
                // Navigate to detailed order delivery information page.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestPage()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
