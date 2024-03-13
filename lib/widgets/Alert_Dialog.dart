/*import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alert extends StatelessWidget {
  final String title;
  final String response;

  Alert({
    Key? key,
    required this.title,
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: AlertDialog(
        title: Text("${title}"),
        content: Text("${response}"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back(),
            child: Text('OK'),
          ),
        ],
      ),
    ));
  }
}*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alert extends StatelessWidget {
  final String title;
  final String response;

  Alert({
    Key? key,
    required this.title,
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(response),
      actions: <Widget>[
        TextButton(
          onPressed: () => Get.back(),
          child: Text('OK'),
        ),
      ],
    );
  }
}
