import 'package:get/get.dart';
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
      Get.snackbar("Successful", "${response.body}");
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
}
