import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalsupport/config/common_bottom_navigation_bar.dart';
import 'package:medicalsupport/config/common_bottom_navigation_floating_button.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';
import 'package:medicalsupport/config/common_drawer.dart';
import 'package:medicalsupport/config/common_app_bar.dart';

class ChatListPage extends StatelessWidget {
  final List<Map<String, String>> chatUsers = [
    {"name": "Kiran Patel", "message": "Hello, I’m FitBot!", "image": "assets/profile1.png"},
    {"name": "John Doe", "message": "See you at 5 PM!", "image": "assets/profile2.png"},
    {"name": "Jane Smith", "message": "Can you send me the report?", "image": "assets/profile3.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      drawer: CommonDrawer(),
      body: ListView.separated(
        itemCount: chatUsers.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(chatUsers[index]["image"]!),
            ),
            title: Text(chatUsers[index]["name"]!),
            subtitle: Text(chatUsers[index]["message"]!),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Get.toNamed(Routes.CHAT); // Navigate to chat page
            },
          );
        },
      ),
      floatingActionButton: CommonBottomNavigationFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 3),
    );
  }
}
