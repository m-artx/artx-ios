import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'product.dart';
import 'service/api_service.dart';
import 'package:http/http.dart' as http;
import 'font_util.dart';

class ProductList extends StatefulWidget {
  final String category;

  ProductList({required this.category});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int currentPage = 0;
  final int pageSize = 10;
  List<dynamic> products = [];
  bool isFetching = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    if(isFetching) return; // 이미 데이터를 가져오고 있다면 중복 실행 방지

    setState(() {
      isFetching = true;
    });

    var productService = ProductService();
    var response = await productService.getCategoryProducts(widget.category, currentPage, pageSize);

    setState(() {
      products = response['content'] ?? [];
      isFetching = false;
      isLastPage = response['lastPage'] ?? false; // 마지막 페이지인지 여부를 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.8,
              ),
              itemCount: products.length, // itemCount를 products의 길이에 맞게 동적으로 설정
  itemBuilder: (context, index) {
    return _buildProductGridItem(index);
              },
            ),
            SizedBox(height: 20),
            Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: currentPage > 0 ? () {
            setState(() {
              currentPage--;
              _fetchProducts();
            });
          } : null, // 첫 페이지에서는 이전 버튼 비활성화
        ),
        Text(
          "페이지 $currentPage",
          style: TextStyle(color: Colors.white),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward, color: Colors.white),
          onPressed: !isLastPage ? () { // 마지막 페이지가 아닐 경우에만 다음 페이지 함수 실행
            setState(() {
              currentPage++;
              _fetchProducts();
            });
          } : null, // 마지막 페이지에서는 다음 버튼 비활성화
        ),
      ],
    ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

Widget _buildProductGridItem(int index) {
  var product = products[index];
  String productId = product['productId'].toString();
  String imageUrl = product['productRepresentativeImage'] ?? 'https://example.com/default-image.png'; // null 대신 기본 이미지
  String title = product['productTitle'] ?? '제품 이름 없음'; // null 대신 기본 문자열

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Product(productId: productId), // 수정된 부분
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                // imageUrl이 null인 경우 기본 이미지를 사용합니다.
                image: NetworkImage(imageUrl),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 10),
      Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
}