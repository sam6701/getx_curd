import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_ecomerce/controllers/cart_controller.dart';
import 'package:getx_ecomerce/screens/cart_Tile.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final userdata = GetStorage();
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
        title: const Text(
          "Cart",
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
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
