import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/colors.dart';
import '../controller/cart_controller.dart';
import '../models/cart_item.dart';
import 'cart_page.dart';

class ProductDetailsPage extends StatefulWidget {
  final String image;
  final String name;
  final String type;
  final double price;
  final double rating;
  final String description;

  const ProductDetailsPage({
    super.key,
    required this.image,
    required this.name,
    required this.type,
    required this.price,
    required this.rating,
    required this.description,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;

  double get totalPrice => widget.price * quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.38,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(color: Colors.grey.shade200),
                    ),
                    Center(
                      child: Image.asset(
                        widget.image,
                        height: MediaQuery.of(context).size.height * 0.26,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // name + rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkGreen,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star,
                            color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          widget.rating.toString(),
                          style: TextStyle(
                            color: AppColors.darkGreen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // type
              Text(
                widget.type,
                style: TextStyle(
                  color: AppColors.darkGreen.withOpacity(0.6),
                ),
              ),

              const SizedBox(height: 14),

              // description
              Text(
                widget.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.darkGreen.withOpacity(0.7),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 4),

              // read more
              Text(
                "Read more",
                style: TextStyle(
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(),

              // quantity
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() => quantity--);
                            }
                          },
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkGreen,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() => quantity++);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // add to cart
              GestureDetector(
                onTap: () {
                  final cartController = Get.find<CartController>();

                  cartController.addToCart(
                    CartItem(
                      name: widget.name,
                      image: widget.image,
                      price: widget.price,
                      quantity: quantity,
                    ),
                  );

                  Get.to(() => CartPage());
                },
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.darkGreen,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "Add to Cart | \$${totalPrice.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
