import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:getx_ecomerce/controllers/cart_controller.dart';
import 'package:getx_ecomerce/services/cart_service.dart';
import 'package:getx_ecomerce/models/cart_api.dart';
import 'package:getx_ecomerce/widgets/Alert_Dialog.dart';

class SelectionController extends GetxController {
  final selectedItems = List<Cart>.empty(growable: true).obs;
  final CartController cartController = Get.put(CartController());
  bool isSelected(int index) {
    final item = cartController.cartList[index];
    return selectedItems.contains(item);
  }

  void toggleSelection(int index) {
    final item = cartController.cartList[index];
    if (isSelected(index)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
  }

  void performAction() {
    Get.dialog(Alert(
        title: "Successful", response: "Selected items: ${selectedItems}"));
  }
}
