import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:getx_ecomerce/controllers/cart_controller.dart';
import 'package:getx_ecomerce/controllers/product_controller.dart';
import 'package:getx_ecomerce/controllers/selection_controller.dart';
import 'package:getx_ecomerce/models/product_api.dart';
import 'package:getx_ecomerce/services/cart_service.dart';
import 'package:getx_ecomerce/models/cart_api.dart';
import 'package:getx_ecomerce/widgets/Alert_Dialog.dart';

class TotalCostController extends GetxController {
  RxDouble totalCost = 0.0.obs as RxDouble; // Observable total cost
  final CartController cartController = Get.put(CartController());
  final SelectionController selectController = Get.put(SelectionController());
  final ProductController productController = Get.put(ProductController());
  @override
  void onInit() {
    super.onInit();
    // Listen to changes in selected items
    ever(selectController.selectedItems, (_) {
      calculateTotalCost();
    });
  }

  void calculateTotalCost() {
    double newTotalCost = 0;

    for (var selectedItem in selectController.selectedItems) {
      for (var product in selectedItem.products) {
        int productId = product.productId;
        int quantity = product.quantity;

        var foundProduct = productController.productList.firstWhere(
          (p) => p.id == productId,
          orElse: () => Product(
              id: 0,
              title: '',
              price: 0,
              description: '',
              category: Category.ELECTRONICS,
              image: '',
              rating: Rating(rate: 0, count: 0)),
        );

        if (foundProduct != null) {
          double price = foundProduct.price;
          newTotalCost += price * quantity;
        }
      }
    }

    // Update the total cost observable
    totalCost.value = newTotalCost;
  }
}
