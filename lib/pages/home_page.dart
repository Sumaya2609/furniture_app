import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/category_button.dart';
import '../components/product_tile.dart';
import '../components/best_seller_tile.dart';
import '../themes/colors.dart';
import '../controller/cart_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // cart controller
    Get.put(CartController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            // Top row
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Discover the Best\nFurniture",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGreen,
                    ),
                  ),
                ),
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage("lib/images/profile.jpg"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // search bar and filter
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search for furniture",
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: AppColors.greyText),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.darkGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.tune, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // categories
            Text(
              "Categories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.darkGreen,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryButton(text: "Chairs", selected: true),
                  CategoryButton(text: "Cupboards", selected: false),
                  CategoryButton(text: "Tables", selected: false),
                  CategoryButton(text: "Lamp", selected: false),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // product tiles
            SizedBox(
              height: 260,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  ProductTile(
                    name: "Modern Chair",
                    type: "Armchair",
                    price: "185",
                    image: "lib/images/chair1.png",
                  ),
                  SizedBox(width: 15),
                  ProductTile(
                    name: "Minimalist Chair",
                    type: "Armchair",
                    price: "258",
                    image: "lib/images/chair2.png",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // best seller
            Text(
              "Best Seller",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.darkGreen,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  BestSellerTile(
                    image: "lib/images/best1.png",
                    name: "Modern Yellow Chair",
                    type: "Armchair",
                    price: "185",
                    rating: 4.9,
                  ),
                  SizedBox(width: 15),
                  BestSellerTile(
                    image: "lib/images/best2.png",
                    name: "Modern Dark Chair",
                    type: "Armchair",
                    price: "185",
                    rating: 4.9,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // navigation bar
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            BottomNavItem(icon: Icons.home, label: "Home", active: true),
            BottomNavItem(icon: Icons.favorite_border, label: "Favorites"),
            BottomNavItem(icon: Icons.qr_code_scanner, label: "Scanner"),
            BottomNavItem(icon: Icons.shopping_cart_outlined, label: "Cart"),
            BottomNavItem(icon: Icons.person_outline, label: "Profile"),
          ],
        ),
      ),
    );
  }
}

// Navigation widget
class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: active ? AppColors.darkGreen : Colors.grey),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: active ? AppColors.darkGreen : Colors.grey,
          ),
        ),
      ],
    );
  }
}
