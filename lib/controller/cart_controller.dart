import 'package:get/get.dart';
import '../models/cart_item.dart';
import '../database/cart_db.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() async {
    cartItems.value = await CartDB.getCart();
  }

  void addToCart(CartItem item) async {
    final index = cartItems.indexWhere((e) => e.name == item.name);

    if (index >= 0) {
      cartItems[index].quantity += item.quantity;
    } else {
      cartItems.add(item);
    }
    cartItems.refresh();
    await CartDB.insertCart(item);
  }

  void removeFromCart(String name) async {
    await CartDB.deleteCart(name);
    loadCart();
  }

  void clearCart() async {
    await CartDB.clearCart();
    cartItems.clear();
  }

  double get totalPrice => cartItems.fold(
        0,
        (sum, item) => sum + item.price * item.quantity,
      );
}
