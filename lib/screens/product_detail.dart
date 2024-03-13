import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_ecomerce/controllers/cart_controller.dart';
import 'package:getx_ecomerce/controllers/login_controller.dart';
import 'package:getx_ecomerce/models/cart_api.dart';
import 'package:getx_ecomerce/models/product_api.dart';
import 'package:getx_ecomerce/models/user_api.dart';
import 'package:getx_ecomerce/services/cart_service.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail(this.product);
  final CartController cartController = Get.put(CartController());
  final UserController userController = Get.put(UserController());
  final userdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    var quantity = 1.obs;
    dynamic us = userdata.read('user');
    int useri = us['id'];
    DateTime dateTime = DateTime.now();
    String dateString = dateTime.toString();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 193, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 205, 193, 236),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: CircleAvatar(
                radius: 110,
                backgroundImage: NetworkImage(product.image),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff2b2b2b),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    product.category.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantity > 1) {
                                quantity--;
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(Icons.remove),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => Text(
                              '$quantity',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              quantity++;
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.add,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => Text(
                          "\$${product.price * quantity.value}",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Descipation",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product.description,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Container(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Cart c = Cart(
                            id: cartController.cartList.last.id + 1,
                            userId: useri,
                            date: dateString,
                            products: [
                              Products(
                                  productId: product.id,
                                  quantity: quantity.value),
                            ],
                            v: 0);
                        CartServices.addCart(c);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 162, 135, 238)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add to Cart",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
