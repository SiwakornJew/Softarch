import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medware/components/bubbled_header.dart';
import 'package:medware/components/notification_bell.dart';
import 'package:medware/utils/api/user/edit_profile_info.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';
import 'package:medware/utils/statics.dart';

class Header extends StatelessWidget {
  final int role;
  final String path;
  final Future<void> Function() refresh;

  const Header({
    Key? key,
    required this.role,
    required this.path,
    required this.refresh,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(path);

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        BubbledHeader(
          role: role,
          percentHeight: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          child: _ScreenTitle(context, role),
        ),
        SizedBox(
          height: size.height * 0.38,
        ),
        Positioned(
          bottom: 0,
          child: _SelectablePic(
            context,
            path,
            refresh,
          ),
        ),
      ],
    );
  }

  Widget _ScreenTitle(BuildContext context, int role) {
    final size = MediaQuery.of(context).size;

    return AppBar(
      elevation: 0,
      title: Text(
        'บัญชีผู้ใช้',
        style: TextStyle(
          color: role == 0 ? primaryColor : quaternaryColor,
          fontSize: size.width * 0.08,
          fontWeight: FontWeight.w900,
        ),
      ),
      toolbarHeight: size.height * 0.12,
      backgroundColor: Colors.transparent,
      actions: [
        NotificationBell(
          backgroundColor: role == 0 ? quaternaryColor : primaryColor,
        ),
      ],
    );
  }

  Widget _SelectablePic(
    BuildContext context,
    String path,
    Future<void> Function() refresh,
  ) {
    final size = MediaQuery.of(context).size;
    final int id = SharedPreference.getUserId();

    return GestureDetector(
      onTap: () {
        // HapticFeedback.lightImpact();
        // showDialog(
        //   context: context,
        //   builder: (context) => Dialog(
        //     elevation: 0,
        //     backgroundColor: Colors.transparent,
        //     alignment: Alignment.center,
        //     child: SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           Text(
        //             'เลือกรูปโปรไฟล์ใหม่',
        //             style: TextStyle(
        //               color: quaternaryColor,
        //               fontSize: size.width * 0.07,
        //               fontWeight: FontWeight.w700,
        //             ),
        //           ),
        //           SizedBox(
        //             height: size.width * 0.075,
        //           ),
        //           GridView.builder(
        //             shrinkWrap: true,
        //             physics: const NeverScrollableScrollPhysics(),
        //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //               crossAxisCount: 2,
        //               crossAxisSpacing: size.width * 0.075,
        //               mainAxisSpacing: size.width * 0.075,
        //             ),
        //             itemCount: profilePictures.length - 1,
        //             itemBuilder: (context, i) => GestureDetector(
        //               onTap: () async {
        //                 await editProfileInfo(
        //                   id: id,
        //                   profileIndex: i,
        //                 );

        //                 Navigator.pop(context);
        //               },
        //               child: Image.asset(
        //                 profilePictures.sublist(1)[i],
        //                 height: size.height * 0.15,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // );
      },
      child: Image.asset(
        path,
        height: size.height * 0.2,
      ),
    );
  }
}
