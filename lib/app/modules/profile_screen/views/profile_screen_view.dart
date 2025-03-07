import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalsupport/services/api_service.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';
import 'package:medicalsupport/config/app_contents.dart';
import 'package:medicalsupport/config/common_button.dart';
import 'package:medicalsupport/config/app_color.dart';
import 'package:medicalsupport/config/common_bottom_navigation_bar.dart';
import 'package:medicalsupport/config/common_bottom_navigation_floating_button.dart';
import 'package:medicalsupport/app/modules/profile_screen/controllers/user_controller.dart';

import '../controllers/profile_screen_controller.dart';

class ProfileScreenView extends StatelessWidget {
	final ProfileScreenController profileScreenController = Get.find();
	final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
	final double screenWidth = MediaQuery.of(context).size.width;
	final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
	  appBar: AppBar(
		title: Text("Profile", style: TextStyle(fontSize: 20)),
		centerTitle: true,
	  ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Picture and Edit Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: userController.profilePicture.value != null && userController.profilePicture.value.isNotEmpty
					//? NetworkImage(userController.profilePicture.value)
					? AssetImage("assets/user.jpeg")
					: AssetImage(Appcontent.defaultLogo) as ImageProvider,
                  ),
                  SizedBox(height: 8),
                  Text(
                    //'@ ${userController.name.value}',
                    'James brook',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
				  SizedBox(height: 8),
                  Text(
                    'jamesl@domain.com | +01 234 567 89',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
					Padding(
					  padding: const EdgeInsets.only(bottom: 16, top: 16),
					  child: Center(
						child: Obx(() {
						  return autoWidthBtn(
							text: profileScreenController.isLoading.value ? 'Loading...' : Appcontent.edit,
							width: screenWidth,
							onPress: profileScreenController.isLoading.value
								? null
								: () {
									profileScreenController.editProfile();									
								},
							);
						}),
					  ),
					),
                ],
              ),
            ),
          ],
        ),
      ),
	  floatingActionButton: CommonBottomNavigationFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
	  bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 4),
    );
  }
}
