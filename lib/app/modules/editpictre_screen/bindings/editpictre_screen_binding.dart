import 'package:get/get.dart';
import 'package:medicalsupport/app/modules/editpictre_screen/controllers/editpictre_screen_controller.dart';

class EditpictreScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditpictreScreenController>(
      () => EditpictreScreenController(),
    );
  }
}
