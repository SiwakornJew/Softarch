import 'package:flutter/material.dart';

class UnderlinedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function() action;
  const UnderlinedButton(
      {Key? key, required this.text, required this.color, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: action,
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: size.width * 0.04,
        ),
      ),
    );
  }
}
