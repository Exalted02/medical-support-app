import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'package:medicalsupport/config/bottom_navigation.dart';
import 'package:medicalsupport/config/snackbar_helper.dart';
import 'package:medicalsupport/services/api_service.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';
import 'package:medicalsupport/config/app_contents.dart';

class ChatController extends GetxController {
	//TODO: Implement ChatController
	final ApiService apiService;
	var isLoading = false.obs;  // RxBool
	var reasonData = <dynamic>[].obs;	
	var chatData = <dynamic>[].obs;	
	
	ChatController(this.apiService);
	
	@override
	void onInit() {
		
	}
	
	// Home page category data
	Future<void> reasonListData() async {
		try {
			var response = await apiService.reasonList();
			var newFeedData = response['data']; 
			reasonData.assignAll(newFeedData);
		} catch (e) {
			print('Error fetching All reasonData - chat controller: $e');
		}
	}
	// Home page category data
	Future<void> chatListData() async {
		try {
			var response = await apiService.chatList();
			var newFeedData = response['data']; 
			chatData.assignAll(newFeedData);
		} catch (e) {
			print('Error fetching All chatData - chat controller: $e');
		}
	}	
	// Home page category data
	Future<Map<String, dynamic>> chatMessageData(String chatGroupId) async {
		try {
			var response = await apiService.chatMessageData(chatGroupId);
			return response;
			//var newFeedData = response['data']; 
			//chatData.assignAll(newFeedData);
		} catch (e) {
			print('Error fetching All chatData - chat controller: $e');
			return {};
		}
	}	
}
