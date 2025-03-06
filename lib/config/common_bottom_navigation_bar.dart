import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalsupport/config/app_color.dart';
import 'package:medicalsupport/config/app_contents.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';
import 'package:medicalsupport/app/modules/profile_screen/controllers/user_controller.dart';
import 'package:medicalsupport/app/modules/order_screen/controllers/cart_controller.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final userController = Get.find<UserController>();
  final CartController cartController = Get.put(CartController());

  CommonBottomNavigationBar({required this.currentIndex});

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        Get.toNamed(Routes.HOME);
        break;
      case 1:
        Get.toNamed(Routes.SERACH_SCREEN);
        break;
      case 2:
        Get.toNamed(Routes.NOTIFICATION_SCREEN);
        break;
      case 3:
        Get.toNamed(Routes.CART_PAGE);
        break;
      case 4:
        Get.toNamed(Routes.PROFILE_SCREEN);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(), // Curve for floating button
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.email, "Email", 0),
              _navItem(Icons.people, "Employees", 1),
              SizedBox(width: 40), // Space for floating button
              _navItem(Icons.chat, "Chat", 3),
              _navItem(Icons.person, "Profile", 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onBottomNavTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: currentIndex == index ? AppColor.purple : AppColor.BlackGreyscale,
            size: 24,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: currentIndex == index ? AppColor.purple : AppColor.BlackGreyscale,
            ),
          ),
        ],
      ),
    );
  }
}
