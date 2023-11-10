import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';

class customer_service extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          SizedBox(height: 21),
          Divider(color: Colors.white), // 검은색 가로줄
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text('공지사항', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.black,
              minimumSize: Size(200, 50),
            ),
          ),
          SizedBox(height: 21),
          ElevatedButton(
            onPressed: () {},
            child: Text('자주하는 질문', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.black,
              minimumSize: Size(200, 50),
            ),
          ),
          SizedBox(height: 21),
          ElevatedButton(
            onPressed: () {},
            child: Text('1:1 문의 내역', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.black,
              minimumSize: Size(200, 50),
            ),
          ),
          SizedBox(height: 21),
          ElevatedButton(
            onPressed: () {},
            child: Text('작가문의 내역', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.black,
              minimumSize: Size(200, 50),
            ),
          ),
          SizedBox(height: 21),
          ElevatedButton(
            onPressed: () {},
            child: Text('작가 전환 신청', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.black,
              minimumSize: Size(200, 50),
            ),
          ),
        ],
      ),
    );
  }
}
