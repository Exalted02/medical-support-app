import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:medicalsupport/config/app_color.dart';
import 'package:medicalsupport/config/common_button.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';
import 'package:medicalsupport/config/app_contents.dart';
import '../controllers/onboarding1_controller.dart';

class Onboarding1View extends GetView<Onboarding1Controller> {
  Onboarding1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildImageSection()), // Image in the middle
            _buildBottomSection(), // Buttons at the bottom
          ],
        ),
      ),
    );
  }

  /// Builds the Image Section in the middle
  Widget _buildImageSection() {
    return Center( // Centering the image
      child: Image.asset(
        Appcontent.maillonglogo, // Provide the path to your image
        width: 200, // Adjust as needed
        height: 200, // Adjust as needed
        fit: BoxFit.contain,
      ),
    );
  }

  /// Builds the Bottom Section with buttons
  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ensures it stays at the bottom
        children: [
          Center(
            child: elevated(
              text: Appcontent.signUpClient,
              onPress: () {
                Get.toNamed(Routes.CLIENT_REGISTER);
              },
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: whiteBgBlackBorderBtn(
              text: Appcontent.signUpEmployee,
              onPress: () {
                Get.toNamed(Routes.EMPLOYEE_REGISTER);
              },
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: textButton(
              text: Appcontent.login,
              width: 327,
              height: 56,
              onPress: () {
                Get.toNamed(Routes.LOGIN_SCREEN);
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
