import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecomerce/controllers/product_controller.dart';

import 'package:getx_ecomerce/models/cart_api.dart';
import 'package:getx_ecomerce/services/cart_service.dart';
import 'package:intl/intl.dart';

class CartTile extends StatelessWidget {
  final Cart cart;
  final Function(bool) onChanged;
  RxBool ChangedValue;
  CartTile(this.cart,
      {super.key, required this.onChanged, required this.ChangedValue});

  @override
  Widget build(BuildContext context) {
    String Datec = cart.date;
    String sDec = Datec.substring(0, 10);
    final ProductController productController = Get.put(ProductController());
    return Row(children: [
      Padding(
        padding: EdgeInsets.only(left: 10),
        child: Obx(() => Checkbox(
              value: ChangedValue.value,
              onChanged: (newValue) {
                ChangedValue.value = newValue ?? false;
                onChanged(ChangedValue.value);
              },
            )),
      ),
      Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.black12),
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                //alignment: Alignment.topRight,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //height: 200,
                    padding: EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${cart.userId}',
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                /*Obx(() => Checkbox(
                                      value: ChangedValue.value,
                                      onChanged: (newValue) {
                                        ChangedValue.value = newValue ?? false;
                                        onChanged(ChangedValue.value);
                                      },
                                    )),*/
                                IconButton(
                                  color: Colors.purple,
                                  icon: Icon(Icons.cancel_outlined),
                                  onPressed: () {
                                    CartServices.deleteCart(cart.id);
                                    Get.back();
                                  },
                                ),
                                IconButton(
                                  color: Colors.purple,
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    // Assuming you want to update some property of the cart
                                    cart.products.add(Products(
                                        productId: cart.products.length,
                                        quantity: cart.userId));
                                    CartServices.updateCart(cart);
                                    Get.back();
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "id:"
                              "${cart.id}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.purple),
                            ),
                            Text(
                              "date:"
                              "${sDec}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.purple),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: cart.products.length,
                                  itemBuilder: (context, cIndex) {
                                    int pq = cart.products[cIndex].quantity;
                                    String image = '';
                                    for (var i
                                        in productController.productList) {
                                      if (i.id ==
                                          cart.products[cIndex].productId) {
                                        image = i.image;
                                        break;
                                      }
                                    }
                                    ;

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
                                              child: CircleAvatar(
                                                backgroundImage:
                                                    NetworkImage(image),
                                              ),
                                            ),
                                            Text(
                                              "${cart.products[cIndex].productId}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.purple),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              color: Colors.purple,
                                              icon: Icon(
                                                Icons.remove_circle_outline,
                                              ),
                                              onPressed: () {},
                                            ),
                                            Text(
                                              "${pq}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.purple),
                                            ),
                                            IconButton(
                                              color: Colors.purple,
                                              icon: Icon(
                                                Icons.add_circle_outline,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    ]);
  }
}
