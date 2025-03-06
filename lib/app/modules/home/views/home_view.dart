import 'package:flutter/material.dart';
import 'package:medicalsupport/config/common_bottom_navigation_bar.dart';
import 'package:medicalsupport/config/common_bottom_navigation_floating_button.dart';
import 'package:medicalsupport/config/common_drawer.dart';
import 'package:medicalsupport/config/common_app_bar.dart'; // Import Common AppBar

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFEDF0F3), // Background color
      appBar: CommonAppBar(),
      drawer: CommonDrawer(),
      body: Center(
        child: Text(
          "Home Page Content Here",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: CommonBottomNavigationFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 0),
    );
  }
}
