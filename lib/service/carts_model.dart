import 'package:flutter/foundation.dart';
import 'api_service.dart';
import '../cart.dart';

class CartsModel extends ChangeNotifier {
  final ProductService _productService = ProductService();
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  // 장바구니 아이템 로드
  Future<void> fetchCartItems() async {
    try {
      // 예시로 1번 카트 아이디 사용
      final response = await _productService.getCartDetails(1);
      final List<dynamic> cartData = response['cartItemDetails'];

      _cartItems = cartData.map((itemData) {
        return CartItem(
          productTitle: itemData['productTitle'] ?? '제품명 없음',
          price: itemData['productPrice'],
          quantity: itemData['cartProductQuantity'],
          image: itemData['productRepresentativeImage'],
          cartId: itemData['cartId'],
          productId: itemData['productId'],
        );
      }).toList();

      notifyListeners();
    } catch (error) {
      print('장바구니 정보 불러오기 실패: $error');
    }
  }

  // 장바구니 아이템 수량 증가
  Future<void> increaseCartItemQuantity(int cartId, int productId) async {
    try {
      await _productService.increaseCartItemQuantity(cartId, productId);
      await fetchCartItems(); // 상태 업데이트
    } catch (error) {
      print('수량 증가 에러: $error');
    }
  }

  // 장바구니 아이템 수량 감소
  Future<void> decreaseCartItemQuantity(int cartId, int productId) async {
    try {
      await _productService.decreaseCartItemQuantity(cartId, productId);
      await fetchCartItems(); // 상태 업데이트
    } catch (error) {
      print('수량 감소 에러: $error');
    }
  }
}
