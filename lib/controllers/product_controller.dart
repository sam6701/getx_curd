import 'package:get/state_manager.dart';
import 'package:getx_ecomerce/models/product_api.dart';
import 'package:getx_ecomerce/services/login_service.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  //var productList = List<Product>().obs;
  RxList<Product> productList = RxList<Product>();

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}
