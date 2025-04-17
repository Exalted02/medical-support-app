import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalsupport/config/snackbar_helper.dart';
import 'package:medicalsupport/config/app_contents.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';
import 'package:medicalsupport/config/common_bottom_navigation_bar.dart';
import 'package:medicalsupport/config/common_bottom_navigation_floating_button.dart';
import 'package:medicalsupport/config/app_color.dart';
import 'package:medicalsupport/config/custom_modal.dart';

import 'package:medicalsupport/app/modules/chat/controllers/chat_controller.dart';
import 'package:medicalsupport/app/modules/profile_screen/controllers/user_controller.dart';

class StartNewChat extends StatefulWidget {
  @override
  State<StartNewChat> createState() => _StartNewChatState();
}

class _StartNewChatState extends State<StartNewChat> {
  final ChatController chatController = Get.find<ChatController>();
  final userController = Get.find<UserController>();
  final TextEditingController reasonTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    chatController.reasonListData();
  }

  void _showAddReasonPopup() {
	showDialog(
		context: context,
		builder: (BuildContext context) {
			return CustomModal(
				title: "Add Reason",
				onClose: () => Get.back(),
				content: Column(
				  mainAxisSize: MainAxisSize.min,
				  children: [
					TextField(
					  controller: reasonTextController,
					  decoration: InputDecoration(
						hintText: "Enter reason title",
						border: OutlineInputBorder(
						  borderRadius: BorderRadius.circular(10),
						),
					  ),
					),
					SizedBox(height: 20),
					Row(
					  children: [
						Expanded(
						  child: OutlinedButton(
							onPressed: () {
							  Get.back(); // Close popup
							},
							child: Text("Cancel"),
						  ),
						),
						SizedBox(width: 10),
						Expanded(
						  child: ElevatedButton(
							onPressed: () async {
							  String newReason = reasonTextController.text.trim();
							  if (newReason.isNotEmpty) {
								final response =
									await chatController.addNewReason(newReason);
								reasonTextController.clear();
								Get.back(); // Close popup
								await Future.delayed(Duration(milliseconds: 300));

								if (response['success']) {
								  chatController.reasonListData();
								  SnackbarHelper.showSuccessSnackbar(
									title: Appcontent.snackbarTitleSuccess,
									message: response['messages'],
								  );
								} else {
								  SnackbarHelper.showErrorSnackbar(
									title: Appcontent.snackbarTitleError,
									message: response['messages'],
								  );
								}
							  }
							},
							style: ElevatedButton.styleFrom(
							  backgroundColor: Colors.deepPurple,
							  foregroundColor: Colors.white,
							),
							child: Text("Submit"),
						  ),
						),
					  ],
					),
				  ],
				),
			);
		},
	);
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
            Get.toNamed(Routes.HOME);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                //alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: _showAddReasonPopup,
                  icon: Icon(Icons.add),
                  label: Text("Add Reason"),
				  style: ElevatedButton.styleFrom(
					backgroundColor: Colors.purple,
					foregroundColor: Colors.white,
					textStyle: TextStyle(fontSize: 16),
				  ),
                ),
              ),
            ),
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

  Widget _buildReasonBadge(BuildContext context, String title,
      {required Map<String, dynamic> data}) {
    final userIdVal = userController.userId.value ?? 0;

    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.CHAT, arguments: {
          'reason_id': data['id'],
          'reason_text': data['reason'],
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
