import 'package:get/get.dart';
import 'package:medicalsupport/app/modules/register/controllers/register_controller.dart';
import 'package:medicalsupport/services/api_service.dart';

class RetailerRegisterBinding extends Bindings {
  @override
  void dependencies() {
	Get.lazyPut<ApiService>(() => ApiService());
	Get.lazyPut<RegisterController>(() => RegisterController(Get.find<ApiService>()));
    //Get.lazyPut<RegisterController>(() => RegisterController(ApiService()));
  }
}
