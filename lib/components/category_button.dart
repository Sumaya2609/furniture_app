import 'package:flutter/material.dart';
import '../themes/colors.dart';

class CategoryButton extends StatelessWidget {
  final String text;
  final bool selected;

  const CategoryButton({
    super.key,
    required this.text,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? AppColors.darkGreen : Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : AppColors.greyText,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
