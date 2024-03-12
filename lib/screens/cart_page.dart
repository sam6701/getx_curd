import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_ecomerce/controllers/cart_controller.dart';
import 'package:getx_ecomerce/screens/cart_Tile.dart';
import 'package:getx_ecomerce/services/cart_service.dart';
//import 'package:flutter_date_range_picker/flutter_date_range_picker.dart'
// as DateRangePicker;
import 'package:intl/intl.dart';

//import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
class CartScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final userdata = GetStorage();

  /*void _showDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await showDatePicker(
      context: context,
      initialFirstDate: DateTime.now(),
      initialLastDate: DateTime.now().add(Duration(days: 7)),
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked.length == 2) {
      DateTime initialDate = picked[0];
      DateTime finalDate = picked[1];
      cartController.SortbydatesCarts(initialDate, finalDate);
    }
  }*/
  /* Future<void> _selectDateRange(BuildContext context) async {
    final DateTime? initialDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (initialDate != null) {
      final DateTime? finalDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (finalDate != null) {
        // Pass selected dates to CartController for sorting
        String formattedInitialDate =
            DateFormat('yyyy-MM-dd').format(initialDate);
        String formattedFinalDate = DateFormat('yyyy-MM-dd').format(finalDate);

        // Parse formatted dates back to DateTime objects
        DateTime parsedInitialDate =
            DateFormat('yyyy-MM-dd').parse(formattedInitialDate);
        DateTime parsedFinalDate =
            DateFormat('yyyy-MM-dd').parse(formattedFinalDate);

        cartController.SortbydatesCarts(parsedInitialDate, parsedFinalDate);
      }
    }
  }*/
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
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 12, 235, 20),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 65,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 162, 135, 238),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "0",
              //"\$ $total",
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
                  icon: Icon(Icons.sort_rounded),
                  onPressed: () {
                    cartController.SortCarts();
                  },
                ),
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
                return CartTile(cartController.cartList[index]);
              });
        }
      }),
    );
  }
}
