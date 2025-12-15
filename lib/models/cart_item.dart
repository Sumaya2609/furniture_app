import 'package:get/get.dart';

class CartItem {
  final String name;
  final String image;
  final double price;
  int quantity;
  RxBool isSelected;
  CartItem({
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
    bool selected = false,
  }) : isSelected = selected.obs;
}
