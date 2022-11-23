import 'package:flutter/material.dart';
import 'package:medware/utils/statics.dart';

class CancelButton extends StatelessWidget {
  final String text;
  final Function() action;
  final double percentWidth;
  const CancelButton(
      {Key? key,
      required this.text,
      required this.action,
      required this.percentWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Ink(
      width: size.width * (percentWidth / 100),
      height: size.height * 0.06,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(size.width * 0.03),
      ),
      child: InkWell(
        onTap: action,
        borderRadius: BorderRadius.circular(
          size.width * 0.03,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: quaternaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
