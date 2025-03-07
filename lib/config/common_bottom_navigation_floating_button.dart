import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalsupport/config/app_color.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';

class CommonBottomNavigationFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.HOME);
        },
        backgroundColor: AppColor.clientTheme,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.dashboard, size: 30),
        elevation: 0,
      ),
    );
  }
}
