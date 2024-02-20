import 'package:flutter/material.dart';

class CustomeTextField extends StatefulWidget {
  final String title;
  final TextInputType type;
  final bool isPassword;
  final TextEditingController controller;

  const CustomeTextField({
    Key? key,
    required this.title,
    required this.type,
    required this.isPassword,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomeTextFieldState createState() => _CustomeTextFieldState();
}

class _CustomeTextFieldState extends State<CustomeTextField> {
  late bool _obscureText;
  
  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.type,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: widget.title,
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
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      onTap: () {},
    );
  }
}
