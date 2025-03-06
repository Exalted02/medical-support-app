import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalsupport/config/app_color.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';

class CommonDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Custom Drawer Header (Same as Image)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white, // White background
            ),
            child: Column(
              children: [
                // Profile Image (Rounded Rectangle)
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
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
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),

                // User Designation
                Text(
                  "Designation",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Drawer Items Below Header
			Expanded(
			  child: Container(
				color: Colors.white, // Set white background for the drawer items
				child: ListView(
				  padding: EdgeInsets.zero,
				  children: [
					_buildDrawerItem(Icons.dashboard, "Dashboard", Routes.HOME, context),
					_buildDrawerItem(Icons.message, "Chat", Routes.PROFILE_SCREEN, context),
					/*_buildDrawerItem(Icons.calendar_today, "Calendar", "/calendar", context),
					_buildDrawerItem(Icons.assignment, "Assigned Tickets", "/assigned_tickets", context),
					_buildDrawerItem(Icons.history, "History", "/history", context),
					Divider(),
					_buildDrawerItem(Icons.policy, "Policies and Procedures", "/policies", context),
					_buildDrawerItem(Icons.video_library, "Video Learning", "/video_learning", context),
					_buildDrawerItem(Icons.update, "Updates", "/updates", context),*/
					ListTile(
					  leading: Icon(Icons.logout, color: Colors.red),
					  title: Text("Logout", style: TextStyle(color: Colors.red)),
					  onTap: () {
						// Handle logout
						Get.offAllNamed("/login");
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
}
