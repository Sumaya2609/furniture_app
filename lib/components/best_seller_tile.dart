import 'package:flutter/material.dart';
import '../themes/colors.dart';

class BestSellerTile extends StatelessWidget {
  final String image;
  final String name;
  final String type;
  final String price;
  final double rating;
  final VoidCallback? onAddTap;

  const BestSellerTile({
    super.key,
    required this.image,
    required this.name,
    required this.type,
    required this.price,
    required this.rating,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // rating
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.darkGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star,
                      color: Colors.amber, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    rating.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.darkGreen,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: AppColors.darkGreen,
              ),
            ),
            Text(
              type,
              style: TextStyle(
                color: AppColors.darkGreen.withOpacity(0.6),
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Text(
                  "\$$price",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGreen,
                  ),
                ),
                const Spacer(),

                // plus button
                if (onAddTap != null)
                  GestureDetector(
                    onTap: onAddTap,
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: AppColors.darkGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
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
