import 'package:get/get.dart';
import 'package:medicalsupport/app/modules/register/controllers/register_controller.dart';
import 'package:medicalsupport/services/api_service.dart';

class ConsumerRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController(ApiService()));
  }
}
