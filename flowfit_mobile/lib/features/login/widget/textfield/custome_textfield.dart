import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  final String title;
  final TextInputType type;
  final bool isPassword;
  const CustomeTextField({
    Key? key, required this.title, required this.type, required this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      keyboardType:type ,
      style: const TextStyle(
        color: Colors.white, 
      ),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: const TextStyle(
          color: Colors.white, 
        ),
        focusColor: Colors.white, 
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.white, 
          ),
        ),
      ),
      onTap: () {

      },
    );
  }
}