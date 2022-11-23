import 'package:flutter/material.dart';
import 'package:medware/utils/statics.dart';

class InputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final String error;
  final bool isNextable;
  final TextEditingController controller;
  final bool? isPassword;
  final Widget? suffix;

  const InputField({
    Key? key,
    required this.label,
    required this.placeholder,
    required this.error,
    required this.isNextable,
    required this.controller,
    this.isPassword,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.width * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.035),
            child: Text(
              label,
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),
          TextField(
            cursorColor: primaryColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: quaternaryColor,
              hintText: placeholder,
              contentPadding: EdgeInsets.all(size.width * 0.035),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.035),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              suffixIcon: suffix,
            ),
            keyboardType: TextInputType.text,
            obscureText: isPassword ?? false,
            textInputAction:
                isNextable ? TextInputAction.next : TextInputAction.done,
            controller: controller,
          ),
          error != ''
              ? Padding(
                  padding: EdgeInsets.only(left: size.width * 0.035),
                  child: Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: size.width * 0.025,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
