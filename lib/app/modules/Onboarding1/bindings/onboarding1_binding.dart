import 'package:get/get.dart';
import 'package:medicalsupport/app/modules/Onboarding1/controllers/onboarding1_controller.dart';
import 'package:medicalsupport/services/api_service.dart';

class Onboarding1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Onboarding1Controller>(() => Onboarding1Controller(ApiService()));
  }
}
