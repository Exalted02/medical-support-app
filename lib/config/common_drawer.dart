import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalsupport/config/app_color.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';
import 'package:medicalsupport/services/api_service.dart';
import 'package:medicalsupport/app/modules/activity_screen/activity_screen_controller.dart';

class CommonDrawer extends StatelessWidget {
  final ActivityScreenController controller = Get.put(ActivityScreenController(Get.find<ApiService>()));

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Custom Drawer Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                // Profile Image
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage("assets/user.jpeg"), // Update with actual image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // User Name
                Text(
                  "Kiran Patel",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                // User Designation
                Text("Designation", style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),

          // Drawer Items Below Header
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(Icons.dashboard, "Dashboard", Routes.HOME, context),
                  _buildDrawerItem(Icons.message, "Chat", Routes.CHAT_LIST, context),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text("Logout", style: TextStyle(color: Colors.red)),
                    onTap: () async {
                      bool confirmLogout = await _showLogoutConfirmationDialog(context);
                      if (confirmLogout) {
                        controller.logout();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, String route, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColor.purple),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Get.toNamed(route);
      },
    );
  }

  // Logout Confirmation Dialog
  Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Confirm Logout"),
            content: Text("Are you sure you want to logout?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Logout", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;
  }
}
