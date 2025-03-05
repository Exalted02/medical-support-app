import 'package:get/get.dart';
import 'package:medicalsupport/services/api_service.dart';
import 'package:medicalsupport/app/modules/editprofile_screen/controllers/editprofile_screen_controller.dart';

class EditprofileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<EditprofileScreenController>(() => EditprofileScreenController(Get.find<ApiService>()));
  }
}
