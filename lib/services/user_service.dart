import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:http/http.dart' as http;
import 'package:getx_ecomerce/models/user_api.dart';

class UserServices {
  static var client = http.Client();

  static Future<List<User>?> fetchUsers() async {
    var response =
        await client.get(Uri.parse('https://fakestoreapi.com/users'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return welcomeFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
