import 'package:flutter/material.dart';
import 'package:medware/components/bubbled_header.dart';
import 'package:medware/components/notification_bell.dart';
import 'package:medware/utils/statics.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';

class Header extends StatelessWidget {
  final int role;
  final String name;
  const Header({Key? key, required this.role, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: size.height * 0.44,
        ),
        BubbledHeader(
          role: role,
          percentHeight: 40,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          child: _ScreenTitle(context, role, name),
        ),
        Positioned(
          bottom: 0,
          child: _WelcomeCard(context),
        ),
      ],
    );
  }

  Widget _ScreenTitle(BuildContext context, int role, String name) {
    final size = MediaQuery.of(context).size;

    return AppBar(
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'สวัสดี!',
            style: TextStyle(
              color: role == 0 ? primaryColor : quaternaryColor,
              fontSize: size.width * 0.12,
              height: 1,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            'คุณ $name',
            style: TextStyle(
              color: role == 0 ? primaryColor : quaternaryColor,
              fontSize: size.width * 0.075,
              height: 1,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
      toolbarHeight: size.height * 0.2,
      backgroundColor: Colors.transparent,
      actions: [
        NotificationBell(
          backgroundColor: role == 0 ? quaternaryColor : primaryColor,
        ),
      ],
    );
  }

  Widget _WelcomeCard(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: size.width * 0.06,
            right: size.width * 0.4,
            top: size.width * 0.055,
          ),
          width: size.width * 0.9,
          height: size.height * 0.2,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0.75,
                blurRadius: 2,
                offset: const Offset(5, 5),
              ),
            ],
            gradient: RadialGradient(
              colors: SharedPreference.getUserRole() == 0
                  ? [primaryColor, secondaryColor]
                  : [tertiaryColor, quaternaryColor],
              center: Alignment.topLeft,
              radius: size.width * 0.0025,
              focal: Alignment.topLeft,
              focalRadius: size.width * 0.0007,
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(size.width * 0.07),
            ),
          ),
          child: Text(
            'อย่าลืมดื่มน้ำให้ครบ\nอย่างน้อย 2 ลิตร\nต่อวันนะ :)',
            style: TextStyle(
                color: SharedPreference.getUserRole() == 0
                    ? quaternaryColor
                    : primaryColor,
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.w600),
          ),
        ),
        Positioned(
          bottom: size.width * -0.03,
          right: size.width * -0.04,
          child: Image.asset(
            'assets/images/drink-water.png',
            height: size.height * 0.18,
          ),
        ),
      ],
    );
  }
}
