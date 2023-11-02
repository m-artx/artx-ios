import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'dart:ui';
import 'service/api_service.dart';
import 'package:http/http.dart' as http;
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
  late String imageUrl; // imageUrl을 late로 선언합니다. 그리고 StatefulWidget의 데이터를 이용하여야 하므로 widget.을 사용합니다.
  late String name;
  late String price;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    ProductService productService = ProductService();
    try {
      final details = await productService.getProductDetails(widget.productId);
      setState(() {
        _productDetails = details;
        // 상품 상세 정보가 로드되면 변수에 할당
        imageUrl = _productDetails!['productImageUrls'][0];
        name = _productDetails!['productTitle'];
        price = "${_productDetails!['productPrice']}원";
      });
    } catch (e) {
      print('Error fetching product details: $e');
    }
  }

 @override
Widget build(BuildContext context) {
  // 데이터가 로드될 때까지 로딩 인디케이터를 표시
  if (_productDetails == null) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  // 데이터가 로드되면 UI를 구성
  List<String> imageUrls = List<String>.from(_productDetails!['productImageUrls']);
  String name = _productDetails!['productTitle'];
  String price = "${_productDetails!['productPrice']}원";

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
                            image: NetworkImage(imageUrls[0]), // 여기를 수정
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        name, // 여기를 수정
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: getFontFamily(name), // 필요하다면 이 부분을 수정
                        ),
                      ),
                      subtitle: Text(
                        price, // 여기를 수정
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: getFontFamily(price), // 필요하다면 이 부분을 수정
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
                          border: Border.all(color: Colors.white, width: 10),
                        ),
                        child: Image.network(imageUrl), // Image.asset를 Image.network로 변경해야 합니다.
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