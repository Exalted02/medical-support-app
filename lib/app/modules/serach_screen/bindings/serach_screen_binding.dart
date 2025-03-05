import 'package:get/get.dart';
import 'package:medicalsupport/services/api_service.dart';
import 'package:medicalsupport/app/modules/serach_screen/controllers/serach_screen_controller.dart';

class SerachScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<SerachScreenController>(() => SerachScreenController(Get.find<ApiService>()));
  }
}
