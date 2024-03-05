import 'package:http/http.dart' as http;
import 'package:getx_ecomerce/models/cart_api.dart';

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
}
