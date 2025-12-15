import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/colors.dart';
import '../pages/product_details_page.dart';
import '../pages/cart_page.dart';
import '../controller/cart_controller.dart';
import '../models/cart_item.dart';

class ProductTile extends StatelessWidget {
  final String name;
  final String type;
  final String price;
  final String image;
  final double rating;

  const ProductTile({
    super.key,
    required this.name,
    required this.type,
    required this.price,
    required this.image,
    this.rating = 4.8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => ProductDetailsPage(
                  image: image,
                  name: name,
                  type: type,
                  price: double.parse(price),
                  rating: rating,
                  description:
                  "Simple & elegant shape makes it very suitable for those want a minimalist room...",
                ));
              },
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "NEW",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star,
                          color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(rating.toString(),
                          style: TextStyle(
                              color: AppColors.darkGreen, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(name,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGreen)),

            Text(type,
                style: TextStyle(
                    fontSize: 12,
                    color: AppColors.darkGreen.withOpacity(0.6))),

            const SizedBox(height: 10),

            Row(
              children: [
                Text("\$$price",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGreen)),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    final cart = Get.find<CartController>();
                    cart.addToCart(CartItem(
                      name: name,
                      image: image,
                      price: double.parse(price),
                    ));
                    Get.to(() => CartPage());
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: AppColors.darkGreen,
                      shape: BoxShape.circle,
                    ),
                    child:
                    const Icon(Icons.add, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
