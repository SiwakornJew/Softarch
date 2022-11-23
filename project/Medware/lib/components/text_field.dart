import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medware/utils/statics.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? validator;
  final bool obscureText;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.obscureText});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        errorStyle: TextStyle(height: 0.6, fontFamily: 'NotoSansThai'),
        errorText: widget.validator,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        isDense: true,
        contentPadding: EdgeInsets.all(6),
        filled: true,
        fillColor: quaternaryColor,
      ),
      controller: widget.controller,
      style: TextStyle(fontFamily: 'NotoSansThai'),
      obscureText: widget.obscureText,
    );
  }
}
