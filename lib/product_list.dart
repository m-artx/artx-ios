import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'product.dart';
import 'service/api_service.dart';

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
    if (isFetching) return;

    setState(() {
      isFetching = true;
    });

    var productService = ProductService();
    var response = await productService.getCategoryProducts(widget.category, currentPage, pageSize);

    setState(() {
      products = response['content'] ?? [];
      isFetching = false;
      isLastPage = response['lastPage'] ?? false;
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
              itemCount: products.length,
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
    String imageUrl = product['productRepresentativeImage'] ?? 'https://example.com/default-image.png';
    String title = product['productTitle'] ?? '제품 이름 없음';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _handleProductTap(productId),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
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

  void _handleProductTap(String productId) async {
    if (!mounted) return;

    try {
      final productService = ProductService();
      final productDetails = await productService.getProductDetails(productId);
      final quantity = productDetails['productQuantity'] ?? 0;

      if (quantity > 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Product(productId: productId),
          ),
        );
      } else {
        _showSoldOutDialog();
      }
    } catch (e) {
      if (!mounted) return;
      print('상품 상세 정보를 가져오는데 실패했습니다: $e');
    }
  }

  void _showSoldOutDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('알림'),
          content: Text('이 제품은 품절되었습니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}






