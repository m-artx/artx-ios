import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'dart:ui';

class Product extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String price;

  Product({required this.imageUrl, required this.name, required this.price});

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  bool _isImageZoomed = false; // 이미지 확대 여부를 판단하는 변수

  String getFontFamily(String text) {
    if (RegExp(r'[가-힣]').hasMatch(text)) {
      return 'EliceDXNeolli';
    } else {
      return 'HemingVariable';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isImageZoomed = !_isImageZoomed;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          widget.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: getFontFamily(widget.name),
                          ),
                        ),
                        subtitle: Text(
                          widget.price,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: getFontFamily(widget.price),
                          ),
                        ),
                        trailing: Icon(Icons.shopping_cart, color: Colors.white),
                      ),
                      TextButton(
                        child: Text(
                          '상품 상세설명',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: getFontFamily('상품 상세설명'),
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 300,
                                child: Center(
                                  child: Text('상품 상세설명 내용'),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                        child: Text(
                          '결제하기',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: getFontFamily('결제하기'),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.yellow),
                        child: Text(
                          '카카오 결제',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: getFontFamily('카카오 결제'),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          if (_isImageZoomed)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isImageZoomed = false;
                  });
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 10),
                        ),
                        child: Image.asset(widget.imageUrl),
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
