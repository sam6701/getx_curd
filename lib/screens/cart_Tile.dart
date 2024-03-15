import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecomerce/controllers/product_controller.dart';

import 'package:getx_ecomerce/models/cart_api.dart';
import 'package:getx_ecomerce/services/cart_service.dart';
import 'package:intl/intl.dart';

class CartTile extends StatelessWidget {
  final Cart cart;
  final Function(bool) onChanged;
  const CartTile(this.cart, {required this.onChanged});

  @override
  Widget build(BuildContext context) {
    String Datec = cart.date;
    String sDec = Datec.substring(0, 10);
    final ProductController productController = Get.put(ProductController());
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: InkWell(
        onTap: () {
          onChanged(true);
        },
        child: Container(
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
                                IconButton(
                                  color: Colors.purple,
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                  ),
                                  onPressed: () {
                                    CartServices.deleteCart(cart.id);
                                    Get.back();
                                  },
                                ),
                                IconButton(
                                  color: Colors.purple,
                                  icon: Icon(
                                    Icons.edit,
                                  ),
                                  onPressed: () {
                                    Cart c = Cart(
                                        date: cart.date,
                                        id: cart.id,
                                        userId: cart.userId,
                                        products: [
                                          Products(
                                              productId: cart.products.length,
                                              quantity: cart.userId),
                                        ],
                                        v: 0);
                                    CartServices.updateCart(c);
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
    );
  }
}
