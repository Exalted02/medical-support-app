import 'package:flutter/material.dart';
import 'package:medicalsupport/config/app_color.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(120), // Ensures enough space
      child: Container(
        color: AppColor.clientTheme,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top), // Prevents overlap
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Row: Menu, Notification, Profile, Name, More Options
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // Custom Drawer Menu Icon
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.menu, color: Color(0xFF5F786D)), // Match theme color
                    ),
                  ),
                  Spacer(),
                  // Notification with Badge
                  Stack(
                    children: [
                      IconButton(
                        icon: Icon(Icons.notifications, color: Colors.white),
                        onPressed: () {},
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "6",
                            style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // User Profile & Name
                  Row(
                    children: [
					  CircleAvatar(
						backgroundImage: AssetImage("assets/user.jpeg"),
					  ),
                      SizedBox(width: 8),
                      Text("Kiran", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  SizedBox(width: 8),
                  // More Options (Three-Dot Menu)
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: Colors.white), // Three-dot icon
                    onSelected: (String value) {
                      if (value == 'change_password') {
                        // Handle Change Password
                        print("Change Password Clicked");
                      } else if (value == 'logout') {
                        // Handle Logout
                        print("Logout Clicked");
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'change_password',
                        child: ListTile(
                          leading: Icon(Icons.lock, color: Colors.black),
                          title: Text('Change Password'),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'logout',
                        child: ListTile(
                          leading: Icon(Icons.exit_to_app, color: Colors.red),
                          title: Text('Logout'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Second Row: Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120); // Ensures AppBar height is enough
}
