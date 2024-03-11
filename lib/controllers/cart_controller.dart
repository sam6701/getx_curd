import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_ecomerce/controllers/login_controller.dart';
import 'package:getx_ecomerce/models/cart_api.dart';
import 'package:getx_ecomerce/models/user_api.dart';
import 'package:getx_ecomerce/services/cart_service.dart';
import 'package:getx_ecomerce/services/user_service.dart';

class CartController extends GetxController {
  var isLoading = true.obs;
  //var productList = List<Product>().obs;
  RxList<Cart> cartList = RxList<Cart>();
  final userdata = GetStorage();
  @override
  void onInit() {
    fetchCarts();
    super.onInit();
  }

  void fetchCarts() async {
    final UserController userController = Get.put(UserController());
    try {
      isLoading(true);
      var id = userdata.read('k');
      var carts = await CartServices.fetchCarts();
      if (carts != null) {
        var filteredCarts = carts.where((cart) => cart.userId == id).toList();
        cartList.value = filteredCarts;
      }
    } finally {
      isLoading(false);
    }
  }
}
