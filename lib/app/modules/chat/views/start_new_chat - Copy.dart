import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';
import 'package:medicalsupport/config/common_bottom_navigation_bar.dart';
import 'package:medicalsupport/config/common_bottom_navigation_floating_button.dart';
import 'package:medicalsupport/config/app_color.dart';

import 'package:medicalsupport/app/modules/chat/controllers/chat_controller.dart';
import 'package:medicalsupport/app/modules/profile_screen/controllers/user_controller.dart';

class StartNewChat extends StatefulWidget {
  @override
  State<StartNewChat> createState() => _StartNewChatState();
}

class _StartNewChatState extends State<StartNewChat> {
	final ChatController chatController = Get.find<ChatController>();
	final userController = Get.find<UserController>();

	@override
	void initState() {
		super.initState();
		chatController.reasonListData();
	}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reason for new chat"),
        backgroundColor: AppColor.clientTheme,
		leading: IconButton(
			icon: Icon(Icons.arrow_back),
			onPressed: () {
			  Get.toNamed(Routes.HOME); // Explicit back navigation
			},
		),
      ),
	  body: SingleChildScrollView(
        child: Column(
          children: [
			Padding(
			  padding: const EdgeInsets.all(16.0),
			  child: Obx(() => Wrap(
				spacing: 10,
				runSpacing: 10,
				children: chatController.reasonData.map((item) {
				  return _buildReasonBadge(
					context,
					item['reason'],
					data: item,
				  );
				}).toList(),
			  )),
			),
		  ],
		),  
	  ),
	  floatingActionButton: CommonBottomNavigationFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 3),
    );
  }
  
  Widget _buildReasonBadge(
	  BuildContext context,
	  String title, {
	  required Map<String, dynamic> data,
	}) {
	  final userIdVal = userController.userId.value ?? 0;
	  //int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
	  //final String uniqueId = '${userIdVal}$timestamp';
	  
	  return GestureDetector(
		onTap: () {
		  Get.toNamed(Routes.CHAT, arguments: {
			'reason_id': data['id'],
			'reason_text': data['reason'],
			//'unique_chat_id': uniqueId,
			'my_id': userIdVal,
		  });
		},
		child: Container(
		  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
		  decoration: BoxDecoration(
			color: AppColor.clientTheme.withOpacity(0.2),
			borderRadius: BorderRadius.circular(25),
		  ),
		  child: Text(
			title,
			style: const TextStyle(
			  color: Colors.deepPurple,
			  fontWeight: FontWeight.w500,
			),
		  ),
		),
	  );
  }

}

