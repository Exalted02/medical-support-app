import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'package:medicalsupport/config/bottom_navigation.dart';
import 'package:medicalsupport/config/snackbar_helper.dart';
import 'package:medicalsupport/services/api_service.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';
import 'package:medicalsupport/config/app_contents.dart';

class HomeController extends GetxController {
	//TODO: Implement HomeController
	final ApiService apiService;
	var isLoading = false.obs;  // RxBool
	HomeController(this.apiService);
	
	@override
	void onInit() {
		
	}
}
