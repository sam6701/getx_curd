import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_ecomerce/controllers/cart_controller.dart';
import 'package:getx_ecomerce/controllers/product_controller.dart';
import 'package:getx_ecomerce/controllers/selection_controller.dart';
import 'package:getx_ecomerce/controllers/total_controller.dart';
import 'package:getx_ecomerce/screens/cart_Tile.dart';
import 'package:getx_ecomerce/services/cart_service.dart';

import 'package:intl/intl.dart';

//import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
var selectedOption = 'Ascending'.obs;

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final SelectionController selectController = Get.put(SelectionController());
  final ProductController productController = Get.put(ProductController());
  final TotalCostController controller = Get.put(TotalCostController());
  final userdata = GetStorage();

  Future<void> _selectDateRange(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime finalDate = DateTime.now();

    // Show the first date picker to select the initial date
    initialDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        ) ??
        initialDate;

    // Show the second date picker to select the final date
    finalDate = await showDatePicker(
          context: context,
          initialDate: finalDate,
          firstDate: initialDate,
          lastDate: DateTime(2100),
        ) ??
        finalDate;

    // Create an instance of CartController

    // Pass selected dates to CartController for sorting
    String formattedInitialDate = DateFormat('yyyy-MM-dd').format(initialDate);
    String formattedFinalDate = DateFormat('yyyy-MM-dd').format(finalDate);

    // Parse formatted dates back to DateTime objects
    DateTime parsedInitialDate =
        DateFormat('yyyy-MM-dd').parse(formattedInitialDate);
    DateTime parsedFinalDate =
        DateFormat('yyyy-MM-dd').parse(formattedFinalDate);

    cartController.SortbydatesCarts(parsedInitialDate, parsedFinalDate);
  }

  @override
  Widget build(BuildContext context) {
    /*final List<IconButton> icons = [
      IconButton(
        icon: Icon(Icons.arrow_circle_up_outlined),
        onPressed: () {
          cartController.SortByAsecCarts();
          Get.back();
        },
      ),
      IconButton(
        icon: Icon(Icons.arrow_circle_down_outlined),
        onPressed: () {
          cartController.SortByDescCarts();
          Get.back();
        },
      ),
    ];

    void _showDropdown(BuildContext context) {
      final RenderBox button = context.findRenderObject() as RenderBox;
      final RenderBox overlay =
          Overlay.of(context).context.findRenderObject() as RenderBox;
      final Offset target = Offset(overlay.size.width,
          button.localToGlobal(Offset.zero, ancestor: overlay).dy);
      final RelativeRect position = RelativeRect.fromLTRB(
        target.dx,
        target.dy,
        target.dx,
        target.dy + button.size.height,
      );

      showMenu(
        context: context,
        position: position,
        items: icons.map((iconButton) {
          return PopupMenuItem(
            child: ListTile(
              leading: iconButton.icon,
              onTap: () {
                iconButton.onPressed?.call();
              },
            ),
          );
        }).toList(),
      );
    }*/

    final List<Obx> radioListTiles = [
      Obx(() => RadioListTile(
            title: Text('Sort By Ascending'),
            value: 'Ascending',
            groupValue: selectedOption.value,
            onChanged: (value) {
              selectedOption.value = value!; // Update selected option
              cartController.SortByAsecCarts(); // Sort cart items
              Get.back(); // Close the dropdown
            },
            activeColor: Colors.purple,
          )),
      Obx(() => RadioListTile(
            title: Text('Sort By Descending'),
            value: 'Descending',
            groupValue: selectedOption.value,
            onChanged: (value) {
              selectedOption.value = value!; // Update selected option
              cartController.SortByDescCarts(); // Sort cart items
              Get.back(); // Close the dropdown
            },
            activeColor: Colors.purple,
          )),
    ];

    void _showDropdown(BuildContext context) {
      final RenderBox button = context.findRenderObject() as RenderBox;
      final RenderBox overlay =
          Overlay.of(context).context.findRenderObject() as RenderBox;
      final Offset target = Offset(overlay.size.width,
          button.localToGlobal(Offset.zero, ancestor: overlay).dy);
      final RelativeRect position = RelativeRect.fromLTRB(
        target.dx,
        target.dy,
        target.dx,
        target.dy + button.size.height,
      );

      showMenu(
        context: context,
        position: position,
        items: radioListTiles.map((radioListTile) {
          return PopupMenuItem(
            child: radioListTile,
          );
        }).toList(),
      );
    }

    return Scaffold(
      bottomNavigationBar: Obx(
        () => Container(
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 65,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 162, 135, 238),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  '\$${controller.totalCost.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              Text(
                // Calculate the sum of quantities of products in selected items
                selectController.selectedItems
                    .fold<int>(
                      0,
                      (previousValue, selectedItem) =>
                          previousValue +
                          selectedItem.products.fold<int>(
                            0,
                            (prev, product) => prev + product.quantity,
                          ),
                    )
                    .toString(),
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                    "pay",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 162, 135, 238),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cart",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.calendar_month_outlined),
                  onPressed: () {
                    //cartController.SortbydatesCarts();
                    _selectDateRange(context);
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.sort_by_alpha_outlined),
                  onPressed: () {
                    //_showDropdown(context, cartController);
                    _showDropdown(context);
                  },
                ), //Icon(Icons.sort_rounded),
              ],
            )
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (cartController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: cartController.cartList.length,
              itemBuilder: (ctx, index) {
                return CartTile(
                  cartController.cartList[index],
                  onChanged: (isChecked) {
                    selectController.toggleSelection(index);
                  },
                  ChangedValue: selectController.isSelected(index),
                );
              });
        }
      }),
    );
  }
}
