import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalsupport/config/app_color.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';
import 'package:medicalsupport/app/modules/profile_screen/controllers/user_controller.dart';

class CommonBottomNavigationFloatingButton extends StatelessWidget {
	final UserController userController = Get.find<UserController>();
	
  @override
  Widget build(BuildContext context) {
	final userType = userController.userType.value ?? 0;
	//print('userType is : $userType');
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
          final route = userType == 1 ? Routes.EMPLOYEE_HOME : Routes.HOME;
          Get.toNamed(route);
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
