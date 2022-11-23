import 'package:flutter/material.dart';
import 'package:medware/utils/statics.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.07,
        vertical: size.width * 0.05,
      ),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
        gradient: RadialGradient(
          colors: [quaternaryColor, tertiaryColor],
          center: Alignment.bottomLeft,
          radius: size.width * 0.003,
          focal: Alignment.bottomLeft,
          focalRadius: size.width * 0.0005,
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(size.width * 0.07),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ติดต่อโรงพยาบาล',
            style: TextStyle(
                color: primaryColor,
                fontSize: size.width * 0.09,
                fontWeight: FontWeight.w700),
          ),
          Text(
            '02-XXX-XXXX',
            style: TextStyle(
                color: primaryColor,
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.w500),
          ),
          Text(
            'โรงพยาบาล Medware ถ.ถนน ต.ตำบล อ.อำเภอ จ.จังหวัด 00000',
            style: TextStyle(
                color: primaryColor,
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
