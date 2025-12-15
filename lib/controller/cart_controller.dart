import 'package:get/get.dart';
import '../models/cart_item.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(CartItem item) {
    final index =
    cartItems.indexWhere((element) => element.name == item.name);

    if (index >= 0) {
      cartItems[index].quantity += item.quantity;
      cartItems.refresh();
    } else {
      cartItems.add(item);
    }
  }

  double get totalPrice => cartItems.fold(
    0,
        (sum, item) => sum + (item.price * item.quantity),
  );


}
