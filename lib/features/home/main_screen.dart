import 'package:billpe/features/bill/add_bill_screen.dart';
import 'package:billpe/features/home/home_screen.dart';
import 'package:billpe/features/order/order_screen.dart';
import 'package:billpe/features/report/report_screen.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  Widget currentScreen() {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ReportScreen();
      case 2:
        return const AddBillScreen();
      case 3:
        return const OrderScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        onTap: (value) {
          if (mounted) {
            setState(() {
              currentIndex = value;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/home.png",
              height: 35,
              width: 42,
            ),
            activeIcon: Image.asset(
              "assets/icons/home_active.png",
              height: 35,
              width: 42,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/lab_profile.png",
              height: 30,
              width: 25,
            ),
            activeIcon: Image.asset(
              "assets/icons/lab_profile_active.png",
              height: 30,
              width: 25,
            ),
            label: "Report",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/assignment_add.png",
              height: 30,
              width: 25,
            ),
            activeIcon: Image.asset(
              "assets/icons/assignment_add_active.png",
              height: 30,
              width: 25,
            ),
            label: "Add Bill",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/quick_reorder.png",
              height: 30,
              width: 25,
            ),
            activeIcon: Image.asset(
              "assets/icons/quick_reorder_active.png",
              height: 30,
              width: 25,
            ),
            label: "Order",
          ),
        ],
      ),
      body: currentScreen(),
    );
  }
}
