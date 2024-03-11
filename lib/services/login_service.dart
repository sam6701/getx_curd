import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:getx_ecomerce/models/product_api.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Product>?> fetchProducts() async {
    var response =
        await client.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return welcomeFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<void> deleteProduct(int productId) async {
    // Send HTTP request to delete the product
    final response = await http.delete(
      Uri.parse('https://fakestoreapi.com/products/$productId'),
    );

    if (response.statusCode == 200) {
      // If the product was successfully deleted, fetch updated data
      RemoteServices.fetchProducts();
    } else {
      // If deleting the product failed, show an error message
      Get.snackbar("Delete Failed", "Please try again.");
    }
  }

  static void updateProduct(Product updatedProduct) async {
    // Send HTTP request to update the product
    final response = await http.put(
      Uri.parse('https://fakestoreapi.com/products/${updatedProduct.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedProduct.toJson()),
    );

    if (response.statusCode == 200) {
      // If the product was successfully updated, fetch updated data
      RemoteServices.fetchProducts();
      print(response.body);
    } else {
      // If updating the product failed, show an error message
      Get.snackbar("Update Failed", "Please try again.");
    }
  }

  static void addProduct(Product newProduct) async {
    // Send HTTP request to add the new product
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newProduct.toJson()),
    );
    //print(response.body);
    //print(response.statusCode);
    if (response.statusCode == 200) {
      // If the product was successfully added, fetch updated data
      RemoteServices.fetchProducts();
      Get.snackbar("Successful", "${response.body}");
    } else {
      // If adding the product failed, show an error message
      Get.snackbar("Add Failed", "Please try again.");
    }
  }
}
