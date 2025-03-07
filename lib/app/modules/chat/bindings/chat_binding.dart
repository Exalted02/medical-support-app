import 'package:get/get.dart';
import 'package:medicalsupport/services/api_service.dart';
import 'package:medicalsupport/app/modules/chat/controllers/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy put for ApiService: It will be created only when needed
    Get.lazyPut<ApiService>(() => ApiService());

    // Lazy put for ChatController, ensure ApiService is already available
    Get.lazyPut<ChatController>(() => ChatController(Get.find<ApiService>()));
  }
}
