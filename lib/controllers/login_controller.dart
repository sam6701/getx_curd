//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_ecomerce/models/user_api.dart';
import 'package:getx_ecomerce/services/user_service.dart';
import 'package:getx_ecomerce/screens/homescreen.dart';

class UserController extends GetxController {
  RxList<User> UserList = RxList<User>();
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  late int k = 0;
  final userdata = GetStorage();
  void fetchUsers() async {
    try {
      var users = await UserServices.fetchUsers();
      if (users != null) {
        UserList.value = users;
      }
    } catch (e) {
      // Handle error gracefully
      Get.snackbar("Error", "Failed to fetch user data. Please try again.");
    }
    String email = emailController.value.text.trim();
    String password = passwordController.value.text.trim();
    var user = UserList.firstWhere((User user) => user.email == email,
        orElse: () => User(
              email: '',
              password: '',
              address: Address(
                  street: '',
                  city: '',
                  geolocation: Geolocation(lat: '', long: ''),
                  zipcode: '',
                  number: 0),
              id: 0,
              username: '',
              name: Name(firstname: '', lastname: ''),
              phone: '',
              v: 0,
            ));
    if (user != null && user.password == password && user.password.isNotEmpty) {
      // Password matches, navigate to home screen or dashboard
      Get.offAll(HomeScreen());
      k = user.id;
      // Example navigation
      userdata.write('isLogged', true);
      userdata.write('user', user);
      userdata.write('k', k);
    } else {
      // Password does not match
      Get.snackbar("Login Failed", "Invalid password. Please try again.");
    }
  }
}
