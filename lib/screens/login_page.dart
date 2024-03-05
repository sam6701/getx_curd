import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecomerce/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.emailController.value,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: controller.passwordController.value,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the login function when the login button is pressed
                controller.fetchUsers();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
