

import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'dart:ui';
import 'service/api_service.dart';
import 'font_util.dart';

class Product extends StatefulWidget {
  final String productId;

  Product({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  bool _isImageZoomed = false;
  Map<String, dynamic>? _productDetails;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    ProductService productService = ProductService();
    try {
      final details = await productService.getProductDetails(widget.productId);
      if (details != null && details.isNotEmpty) {
        setState(() {
          _productDetails = details;
        });
      }
    } catch (e) {
      print('Error fetching product details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_productDetails == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    

    String imageUrl = _productDetails!['productRepresentativeImage'] ?? 'assets/images/image1.jpeg';
    String name = _productDetails!['productTitle'] ?? '제품 이름 없음';
    String price = "${_productDetails!['productPrice']}원";
    String productDescription = _productDetails!['productDescription'] ?? '상품 설명이 없습니다.';

    ImageProvider imageProvider;
    if (_productDetails != null && _productDetails!['productRepresentativeImage'] != null) {
      imageProvider = NetworkImage(_productDetails!['productRepresentativeImage']);
    } else {
      imageProvider = AssetImage('assets/images/image1.jpeg');
    }

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
                              fit: BoxFit.cover,
                              image: imageProvider,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: getFontFamily(name),
                          ),
                        ),
                        subtitle: Text(
                          price,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: getFontFamily(price),
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
                                  child: Text(productDescription),
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
                margin: EdgeInsets.only(left: 5, right: 5, bottom: 20),
                child: Center(
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
                          border: Border.all(color: Colors.white, width: 10),
                        ),
                        child: Image.network(imageUrl), // 수정됨
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

}


