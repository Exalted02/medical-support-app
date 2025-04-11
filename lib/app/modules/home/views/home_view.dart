import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';
import 'package:medicalsupport/config/common_bottom_navigation_bar.dart';
import 'package:medicalsupport/config/common_bottom_navigation_floating_button.dart';
import 'package:medicalsupport/config/common_drawer.dart';
import 'package:medicalsupport/config/common_app_bar.dart'; // Import Common AppBar
import 'package:fl_chart/fl_chart.dart';

import 'package:medicalsupport/app/modules/chat/controllers/chat_controller.dart';
import 'package:medicalsupport/app/modules/profile_screen/controllers/user_controller.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
	final ChatController chatController = Get.find<ChatController>();
	final userController = Get.find<UserController>();
  
	@override
	void initState() {
		super.initState();
		chatController.chatListData();
	}
	
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFEDF0F3), // Background color
      appBar: CommonAppBar(),
      drawer: CommonDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNewChatBtn(),
            SizedBox(height: 10),
			Obx(() => _buildDashboardCards()),
            SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButton: CommonBottomNavigationFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 2),
    );
  }
  
  Widget _buildNewChatBtn() {
	  return SizedBox(
		width: double.infinity,
		child: ElevatedButton.icon(
		  onPressed: () {
			// Navigate to the new chat page using named route
			Navigator.pop(context); // Optional: close drawer if needed
			Get.toNamed(Routes.START_NEW_CHAT); // Replace with your actual route
		  },
		  icon: Icon(Icons.add_comment),
		  label: Text("Start New Chat"),
		  style: ElevatedButton.styleFrom(
			backgroundColor: Colors.purple,
			foregroundColor: Colors.white,
			padding: EdgeInsets.symmetric(vertical: 14),
			textStyle: TextStyle(fontSize: 16),
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
		  ),
		),
	  );
  }

  // 🔹 Dashboard Cards (Ongoing & Solved Queries)
  Widget _buildDashboardCards() {
	final userIdVal = userController.userId.value ?? 0;
	
	  return Column(
		children: chatController.chatData.map((item) {
		  return Padding(
			padding: const EdgeInsets.symmetric(vertical: 6),
			child: InkWell(
			  onTap: () {
				Get.toNamed(Routes.CHAT, arguments: {
					'reason_id': int.tryParse(item['reason_id'].toString()) ?? 0,
					'reason_text': item['issue'],
					'unique_chat_id': item['unique_chat_id'],
					'receiver_id': item['receiver_id'],
					'chat_group_id': item['chat_group_id'],
					'my_id': userIdVal,
				});
			  },
			  borderRadius: BorderRadius.circular(12), // Match card shape if needed
			  child: _buildCard(
				item['ticket_number'] ?? '',
				item['resident'] ?? '',
				item['timestamp'] ?? '',
				item['issue'] ?? '',
				item['assigned_to'] ?? '',
			  ),
			),
		  );
		}).toList(),
	  );
	}

  /*Widget _buildDashboardCards() {
	  return Column(
		children: chatController.chatData.map((item) {
		  return Padding(
			padding: const EdgeInsets.symmetric(vertical: 6),
			child: _buildCard(
			  item['ticket_number'] ?? '',
			  item['resident'] ?? '',
			  item['timestamp'] ?? '',
			  item['issue'] ?? '',
			  item['assigned_to'] ?? '',
			),
		  );
		}).toList(),
	  );
  }*/


  Widget _buildCard(String ticket_number, String resident, String timestamp, String issue, String assigned_to) {
    return Container(
		//width: MediaQuery.of(context).size.width * 0.45,
		padding: EdgeInsets.all(16),
		decoration: BoxDecoration(
		  color: Colors.white,
		  borderRadius: BorderRadius.circular(10),
		  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
		),
		child: Column(
		  crossAxisAlignment: CrossAxisAlignment.start,
		  children: [
			Row(
			  mainAxisAlignment: MainAxisAlignment.spaceBetween,
			  children: [
				Text(
				  'Ticket #${ticket_number}',
				  style: TextStyle(fontWeight: FontWeight.bold),
				),
				Container(
				  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
				  decoration: BoxDecoration(
					color: Colors.green[100],
					borderRadius: BorderRadius.circular(4),
				  ),
				  child: Text(
					'Active ticket',
					style: TextStyle(
					  color: Colors.green[800],
					  fontSize: 12,
					  fontWeight: FontWeight.w500,
					),
				  ),
				),
			  ],
			),
			SizedBox(height: 10),
			_buildDetailRow('Resident:', resident),
			_buildDetailRow('Timestamp:', timestamp),
			_buildDetailRow('Issue :', issue),
			_buildDetailRow('Assigned to :', assigned_to),
		  ],
		),
	);
  }
  
  Widget _buildDetailRow(String label, String value) {
	  return Padding(
		padding: const EdgeInsets.symmetric(vertical: 2),
		child: Row(
		  crossAxisAlignment: CrossAxisAlignment.start,
		  children: [
			Text(
			  '$label ',
			  style: TextStyle(color: Colors.black87),
			),
			Expanded(
			  child: Text(
				value,
				style: TextStyle(
				  fontWeight: FontWeight.bold,
				  color: Colors.black87,
				),
			  ),
			),
		  ],
		),
	  );
  }
}
