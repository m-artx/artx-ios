import 'package:flutter/material.dart';
import 'product_list.dart';
import 'artist_center.dart';
import 'cart.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black.withOpacity(0.9),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.transparent),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Close the drawer first
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()), // Replace CartPage with the name of your cart page class
                      );
                    },
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(5, -30), // 음수 값을 사용하여 위로 조정
              child: Column(
                children: [
                  _buildMenuItem(context, '작품', subItems: ['ART', 'CERAMIC', 'ETC']),
                  _buildMenuItem(context, '고객센터', subItems: ['공지사항', '공지사항 관리', '자주하는 질문', '1:1 문의', '1:1문의 관리', '작가 전환 신청']),
                  _buildMenuItem(context, '마이페이지', subItems: ['개인정보 관리', '주문/배송정보', '배송지 관리', '비밀번호 변경']),
                  _buildMenuItem(context, '작가 센터', subItems: ['상품 관리', '문의 관리', '개인 커미션 관리']),
                  _buildMenuItem(context, '관리자센터', subItems: ['작가 전환 관리', '주문 관리', '배송 관리', '회원 관리']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, {List<String>? subItems}) {
    TextStyle mainMenuStyle = TextStyle(color: Colors.white, fontFamily: 'EliceDXNeolli', fontSize: 17);  
    TextStyle subMenuStyle = TextStyle(color: Colors.white, fontFamily: 'EliceDXNeolli', fontSize: 15);  
    
    Widget menuItem;
  
    if (subItems != null && subItems.isNotEmpty) {
        menuItem = ExpansionTile(
          title: Text(title, style: mainMenuStyle),
          children: subItems.map((subItem) => ListTile(
            title: Text(subItem, style: subMenuStyle),
            onTap: () {
              Navigator.pop(context);
              if (['ART', 'CERAMIC', 'ETC'].contains(subItem)) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductList(category: subItem)),
                );
              } else if (subItem == '상품 관리') {
                // 여기에서 "상품 관리" 항목이 클릭되었을 때의 이동 로직을 추가합니다.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArtistProductList()), // 'ArtistProductList'는 대상 페이지의 클래스 이름입니다.
                );
              }
              // 다른 메뉴 항목들에 대한 처리를 필요에 따라 추가할 수 있습니다.
            },
          )).toList(),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
        );
      } else {
        menuItem = ListTile(
          title: Text(title, style: mainMenuStyle),
          onTap: () {
            Navigator.pop(context);
            // TODO: 페이지 이동 코드
          },
        );
      }
  
    // 메뉴와 메뉴 사이의 간격을 조절
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: menuItem,
    );
  }
}
