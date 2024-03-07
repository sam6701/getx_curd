import 'package:flutter/material.dart';
import 'package:getx_ecomerce/models/cart_api.dart';

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
                      Text(
                        '${cart.userId}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
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
                      )
                    ],
                  ),
                ),
                /*IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: onTap,
                )*/
              ],
            )),
          ],
        ),
      ),
    );
  }
}
