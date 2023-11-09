import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'font_util.dart';
import 'service/api_service.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<CartItem> cartItems = [];
  final ProductService _productService = ProductService(); // 서비스 인스턴스 생성

  @override
  void initState() {
    super.initState();
    _fetchCartItems(); // initState에서 장바구니 아이템들을 불러옵니다.
  }

  // API를 통해 장바구니 정보를 불러오는 메소드
  Future<void> _fetchCartItems() async {
    try {
      // 예시로 1번 카트 아이디를 사용합니다. 실제로는 동적으로 설정할 수 있어야 합니다.
      final response = await _productService.getCartDetails(1);

      // API 응답에서 장바구니 아이템 리스트를 추출합니다.
      final List<dynamic> cartData = response['cartItemDetails'];

      // CartItem 리스트를 생성합니다.
      final List<CartItem> loadedCartItems = cartData.map((itemData) {
        return CartItem(
          productTitle: itemData['productTitle'] ?? '제품명 없음', //null 처리, 기본이름 제공
          price: itemData['productPrice'], // API 문서에 따라 productPrice로 변경됨
          quantity: itemData['cartProductQuantity'],
          image: itemData['productRepresentativeImage'], // 이미지 URL 추가
          cartId: itemData['cartId'], // cartId를 API 응답에서 추출해야 함
          productId: itemData['productId'],
        );
      }).toList();

      // 상태 업데이트
      setState(() {
        cartItems = loadedCartItems;
      });
    } catch (error) {
      print('장바구니 정보 불러오기 실패: $error');
    }
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
            ...cartItems.map((item) => CartItemWidget(item: item, productService: _productService)).toList(),
            CartSummary(cartItems: cartItems),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 23, 23, 23), // 이전 배경색 유지
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // 버튼 배경색
                padding: EdgeInsets.symmetric(vertical: 10.0),
                elevation: 0, // 버튼 그림자 제거
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // 테두리 둥글기 제거
                ),
              ),
              child: Text(
                '결제하기',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: getFontFamily('결제하기'),
                ),
              ),
              onPressed: () {
                // 추후 결제 연결
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CartItem {
  final String? productTitle;
  final int price;
  final int quantity;
  final String? image;
  final int cartId; // cartId 속성 추가
  final int productId; // productId 속성 추가

  CartItem({
    this.productTitle,
    required this.price,
    required this.quantity,
    this.image,
    required this.cartId, // cartId는 필수 인자로 변경
    required this.productId, // productId는 필수 인자로 변경
  });
}

class CartItemWidget extends StatefulWidget {
  final CartItem item;
  final ProductService productService; // ProductService 추가

  CartItemWidget({required this.item, required this.productService}); // 생성자 수정

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}


class _CartItemWidgetState extends State<CartItemWidget> {
  late int quantity;
  late ProductService _productService; // _productService 선언

  @override
  void initState() {
    super.initState();
    quantity = widget.item.quantity;
    _productService = widget.productService; // _productService 초기화
  }

  void _increaseQuantity() async {
    try {
      await _productService.increaseCartItemQuantity(widget.item.cartId, widget.item.productId);
      setState(() {
        quantity++;
      });
    } catch (error) {
      print('수량 증가 에러: $error');
    }
  }

  void _decreaseQuantity() async {
    if (quantity > 1) { // 수량이 1보다 클 때만 감소 가능
      try {
        await _productService.decreaseCartItemQuantity(widget.item.cartId, widget.item.productId);
        setState(() {
          quantity--;
        });
      } catch (error) {
        print('수량 감소 에러: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              widget.item.image ?? '기본이미지URL', // item.image가 null일 경우 기본 이미지 URL 사용
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.productTitle ?? '제품명 없음',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${widget.item.price}원',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: _decreaseQuantity,
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _increaseQuantity,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // 제거 로직
              },
            ),
          ],
        ),
      ),
    );
  }
}

// CartSummary를 실제 내용으로 채워넣기
class CartSummary extends StatelessWidget {
  final List<CartItem> cartItems;

  CartSummary({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    int total = cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('총 상품금액'),
              Text('${total}원'),
            ],
          ),
          // 추가 비용 항목들을 여기에 추가할 수 있습니다.
        ],
      ),
    );
  }
}
