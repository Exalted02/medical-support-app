import 'package:get/get.dart';
import 'package:medicalsupport/services/api_service.dart';
import 'package:medicalsupport/app/modules/product/controllers/product_controller.dart';

/*class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(
      () => ProductController(Get.find<ApiService>(), Get.parameters['productId']!),
    );
  }
}*/



class ProductBinding extends Bindings {
	@override
	void dependencies() {
		// Register the ApiService first
		Get.put(ApiService());

		// Now register the EditpostScreenController
		final args = Get.arguments as Map<String, dynamic>;
		String productId = args['productId']; // Get the productId from arguments
		Get.put(ProductController(Get.find<ApiService>(), productId));
	}
}