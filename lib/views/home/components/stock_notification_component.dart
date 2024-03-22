import 'package:billpe/views/stock/stock_router.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class StockNotificationComponent extends StatelessWidget {
  const StockNotificationComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            HapticFeedback.selectionClick();
            context.push(StockPath.stock);
          },
          icon: Image.asset("assets/icons/inventory.png"),
          label: const Text(
            "Stock",
            style: TextStyle(color: Colors.black),
          ),
        ),
        const Row(
          children: [
            Icon(
              Icons.circle_notifications_outlined,
              size: 32,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "XX Items low in stock",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
