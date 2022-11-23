import 'package:flutter/material.dart';
import 'package:medware/utils/statics.dart';

class Label extends StatelessWidget {
  final String fName;
  final String mName;
  final String lName;
  final String role;

  const Label({
    Key? key,
    required this.fName,
    required this.mName,
    required this.lName,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Text(
          '${fName} ${mName} ${lName}',
          style: TextStyle(
            color: primaryColor,
            fontSize: size.width * 0.065,
            fontWeight: FontWeight.w700,
          ),
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
        ),
        Text(
          role,
          style: TextStyle(
            color: primaryColor,
            fontSize: size.width * 0.05,
          ),
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
        ),
      ],
    );
  }
}
