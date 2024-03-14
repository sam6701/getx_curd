import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_ecomerce/widgets/Alert_Dialog.dart';
import 'package:http/http.dart' as http;
import 'package:getx_ecomerce/models/cart_api.dart';
import 'package:intl/intl.dart';

class CartServices {
  static var client = http.Client();

  static Future<List<Cart>?> fetchCarts() async {
    var response =
        await client.get(Uri.parse('https://fakestoreapi.com/carts'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return welcomeFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<void> deleteCart(int CardId) async {
    // Send HTTP request to delete the product
    final response = await http.delete(
      Uri.parse('https://fakestoreapi.com/carts/$CardId'),
    );

    if (response.statusCode == 200) {
      // If the product was successfully deleted, fetch updated data
      //CartServices.fetchProducts();
      //print(response.body);
      //Get.snackbar("Successful", "${response.body}");
      Get.dialog(Alert(title: "Successful", response: response.body));
    } else {
      // If deleting the product failed, show an error message
      Get.snackbar("Delete Failed", "Please try again.");
    }
  }

  static Future<List<Cart>?> SortCarts() async {
    var response =
        await client.get(Uri.parse('https://fakestoreapi.com/carts?sort=desc'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return welcomeFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<List<Cart>?> SortbyasecCarts() async {
    var response =
        await client.get(Uri.parse('https://fakestoreapi.com/carts?sort=asc'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return welcomeFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<List<Cart>?> SortbydateCarts(
      DateTime initial, DateTime finaldate) async {
    String formattedInitialDate = DateFormat('yyyy-MM-dd').format(initial);
    String formattedFinalDate = DateFormat('yyyy-MM-dd').format(finaldate);
    var response = await client.get(Uri.parse(
        'https://fakestoreapi.com/carts?startdate=$formattedInitialDate&enddate=$formattedFinalDate'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return welcomeFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static void addCart(Cart newCart) async {
    // Send HTTP request to add the new product
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/carts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newCart.toJson()),
    );
    //print(response.body);
    //print(response.statusCode);
    if (response.statusCode == 200) {
      // If the product was successfully added, fetch updated data
      CartServices.fetchCarts();
      //Get.snackbar("Successful", "${response.body}");
      Get.dialog(Alert(title: "Successful", response: response.body));
    } else {
      // If adding the product failed, show an error message
      Get.snackbar("Add Failed", "Please try again.");
    }
  }

  static void updateCart(Cart updatedCart) async {
    // Send HTTP request to update the product
    final response = await http.put(
      Uri.parse('https://fakestoreapi.com/products/${updatedCart.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedCart.toJson()),
    );

    if (response.statusCode == 200) {
      // If the product was successfully updated, fetch updated data
      CartServices.fetchCarts();
      print(response.body);
      Get.dialog(Alert(title: "Successful", response: response.body));
    } else {
      // If updating the product failed, show an error message
      Get.snackbar("Update Failed", "Please try again.");
    }
  }
}
