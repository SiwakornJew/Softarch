import 'package:flutter/material.dart';
import 'package:medware/utils/statics.dart';

class BubbledHeader extends StatelessWidget {
  final int role;
  final double percentHeight;
  final Widget? header;
  
  const BubbledHeader({
    Key? key,
    required this.role,
    required this.percentHeight,
    this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * (percentHeight / 100),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: role == 0
              ? [tertiaryColor, quaternaryColor]
              : [primaryColor, secondaryColor],
          center: Alignment.topRight,
          radius: size.width * 0.0025,
          focal: Alignment.topRight,
          focalRadius: size.width * 0.0007,
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(
            size.height * 0.3,
            size.height * 0.06,
          ),
        ),
      ),
      child: header,
    );
  }
}
