import 'package:get/get.dart';
import 'package:medicalsupport/services/api_service.dart';
import 'package:medicalsupport/app/modules/profile_screen/controllers/profile_screen_controller.dart';
import 'package:medicalsupport/app/modules/profile_screen/controllers/user_controller.dart';

class ProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController(Get.find<ApiService>()));
	// Initialize UserController
    Get.lazyPut<UserController>(() => UserController());
  }
}
