import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalsupport/config/app_color.dart';

class CommonDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Kiran Patel"),
            accountEmail: Text("Designation"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"), // Replace with actual image path
            ),
            decoration: BoxDecoration(
              color: AppColor.white, // Change based on your theme
            ),
          ),
          _buildDrawerItem(Icons.dashboard, "Dashboard", "/dashboard"),
          _buildDrawerItem(Icons.email, "Email", "/email"),
          _buildDrawerItem(Icons.calendar_today, "Calendar", "/calendar"),
          _buildDrawerItem(Icons.assignment, "Assigned Tickets", "/assigned_tickets"),
          _buildDrawerItem(Icons.history, "History", "/history"),
          Divider(),
          _buildDrawerItem(Icons.policy, "Policies and Procedures", "/policies"),
          _buildDrawerItem(Icons.video_library, "Video Learning", "/video_learning"),
          _buildDrawerItem(Icons.update, "Updates", "/updates"),
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
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: AppColor.purple),
      title: Text(title),
      onTap: () {
        Get.toNamed(route);
      },
    );
  }
}
