import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecomerce/models/product_api.dart';
import 'package:getx_ecomerce/screens/modify_page.dart';
import 'package:getx_ecomerce/screens/product_detail.dart';
import 'package:getx_ecomerce/services/login_service.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetail(product));
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                product.title,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: 'avenir', fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              if (product.rating.rate != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.rating.rate.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 8),
              Text('\$${product.price}',
                  style: TextStyle(fontSize: 32, fontFamily: 'avenir')),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  product.category.name,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Row(
                  children: [
                    IconButton(
                      color: Colors.red,
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Product'),
                              content: Text(
                                  'Are you sure you want to delete this product?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Delete'),
                                  onPressed: () {
                                    // Call the deleteProduct function to delete the product
                                    RemoteServices.deleteProduct(product.id);
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      color: Colors.green,
                      icon: const Icon(
                        Icons.edit,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ModifyPage(
                              onProductSubmitted: RemoteServices.updateProduct,
                              list_size: product.id,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
