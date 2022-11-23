import 'package:flutter/material.dart';
import 'package:medware/components/bubbled_header.dart';
import 'package:medware/utils/statics.dart';

class Header extends StatelessWidget {
  final int role;
  final String title;
  
  const Header({
    Key? key,
    required this.role,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        BubbledHeader(
          role: role,
          percentHeight: 30,
          header: SafeArea(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: role == 0 ? primaryColor : quaternaryColor,
                    fontSize: size.width * 0.08,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.3,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: role == 0 ? primaryColor : quaternaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
