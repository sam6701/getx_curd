import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecomerce/controllers/product_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:getx_ecomerce/screens/adding_page.dart';
import 'package:getx_ecomerce/screens/product_tile.dart';
import 'package:getx_ecomerce/screens/product_detail.dart';
import 'package:getx_ecomerce/screens/cart_page.dart';
import 'package:getx_ecomerce/services/login_service.dart';

class HomeScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Get.to(CartScreen());
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              //Get.to(CartScreen());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddingPage(
                    onProductSubmitted: RemoteServices.addProduct,
                    list_size: productController.productList.last.id,
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'E-Shop',
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontSize: 32,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return AlignedGridView.count(
                  crossAxisCount: 2,
                  itemCount: productController.productList.length,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  itemBuilder: (context, index) {
                    return ProductTile(productController.productList[index]);
                  },
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
