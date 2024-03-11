import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String lText;
  final String hiText;
  final TextInputType inputType;
  final TextEditingController controll;
  final String? Function(String?)? validator;
  TextFieldWidget(
      {Key? key,
      required this.lText,
      required this.hiText,
      required this.inputType,
      required this.controll,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: TextFormField(
        // Set text style
        style: TextStyle(fontSize: 18),
        cursorColor: Colors.black,
        keyboardType: inputType,
        controller: controll,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          focusColor: Colors.black,
          hintStyle: TextStyle(color: Colors.black),
          labelText: lText,
          hintText: hiText,
        ),
        validator: validator,
      ),
    );
  }
}
