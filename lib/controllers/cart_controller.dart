import 'package:get/state_manager.dart';
import 'package:getx_ecomerce/models/cart_api.dart';
import 'package:getx_ecomerce/models/user_api.dart';
import 'package:getx_ecomerce/services/cart_service.dart';
import 'package:getx_ecomerce/services/user_service.dart';

class CartController extends GetxController {
  var isLoading = true.obs;
  //var productList = List<Product>().obs;
  RxList<Cart> cartList = RxList<Cart>();

  @override
  void onInit() {
    fetchCarts();
    super.onInit();
  }

  void fetchCarts() async {
    try {
      isLoading(true);
      var id = 1;
      var carts = await CartServices.fetchCarts();
      if (carts != null) {
        var filteredCarts = carts.where((cart) => cart.id == id).toList();
        cartList.value = filteredCarts;
      }
    } finally {
      isLoading(false);
    }
  }
}
