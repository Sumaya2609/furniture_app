import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../themes/colors.dart';
import '../models/cart_item.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(
                () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // top bar
                Row(
                  children: [
                    _circleIcon(
                      icon: Icons.arrow_back,
                      onTap: () => Get.back(),
                    ),
                    const Spacer(),
                    Text(
                      "Cart",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkGreen,
                      ),
                    ),
                    const Spacer(),
                    _circleIcon(
                      icon: Icons.delete_outline,
                      onTap: () => cartController.cartItems.clear(),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // cart items
                Expanded(
                  child: ListView(
                    children: [
                      ...cartController.cartItems.map(
                            (item) => _cartItemCard(item),
                      ),

                      const SizedBox(height: 20),

                      // recently viewed
                      Text(
                        "Recently View",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkGreen,
                        ),
                      ),

                      const SizedBox(height: 12),

                      if (cartController.cartItems.isNotEmpty)
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.asset(
                            cartController.cartItems.last.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // container
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Total (${cartController.cartItems.length} Items):",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.darkGreen.withOpacity(0.7),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "\$${cartController.totalPrice.toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGreen,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // proceed button
                      Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.darkGreen,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            "Proceed to Checkout",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // circle icon
  Widget _circleIcon({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        width: 42,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.darkGreen),
      ),
    );
  }

  // cart item with tick mark
  Widget _cartItemCard(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          // tick mark checkbox
          Obx(() => GestureDetector(
            onTap: () {
              item.isSelected.value = !item.isSelected.value;
            },
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: item.isSelected.value ? AppColors.darkGreen : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.darkGreen),
              ),
              child: item.isSelected.value
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          )),
          const SizedBox(width: 12),

          // image
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.lightGreen,
            ),
            child: Image.asset(item.image, fit: BoxFit.contain),
          ),

          const SizedBox(width: 12),

          // details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGreen,
                  ),
                ),
                Text(
                  "Armchair",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.darkGreen.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${item.price.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGreen,
                  ),
                ),
              ],
            ),
          ),

          // quantity
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (item.quantity > 1) {
                    item.quantity--;
                    cartController.cartItems.refresh();
                  }
                },
              ),
              Text(
                item.quantity.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkGreen,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  item.quantity++;
                  cartController.cartItems.refresh();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _recentlyViewedCard(CartItem item) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        // image
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.lightGreen,
          ),
          child: Image.asset(item.image, fit: BoxFit.contain),
        ),
        const SizedBox(width: 12),

        // details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkGreen,
                ),
              ),
              Text(
                "Armchair", // or item.type if you have
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.darkGreen.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "\$${item.price.toStringAsFixed(0)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

