import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecomerce/models/cart_api.dart';
import 'package:getx_ecomerce/services/cart_service.dart';

class CartTile extends StatelessWidget {
  final Cart cart;
  const CartTile(this.cart);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.black12),
        child: Row(
          children: [
            /*Container(
              padding: EdgeInsets.only(left: 20),
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.image),
              ),
            ),*/
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: 200,
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
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.cancel_outlined,
                                ),
                                onPressed: () {
                                  CartServices.deleteCart(cart.id);
                                  Get.back();
                                },
                              ),
                              IconButton(
                                color: Colors.white,
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
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            "date:"
                            "${cart.date}",
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "pid:"
                                        "${cart.products[cIndex].productId}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            color: Colors.white,
                                            icon: Icon(
                                              Icons.remove_circle_outline,
                                            ),
                                            onPressed: () {},
                                          ),
                                          Text(
                                            "pidqu:"
                                            "${pq}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          IconButton(
                                            color: Colors.white,
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
    );
  }
}
