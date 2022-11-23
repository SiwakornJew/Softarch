import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medware/utils/statics.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({Key? key}) : super(key: key);

  @override
  _NotificationSettingState createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  final int role = SharedPreference.getUserRole();
  bool isNotified = true;
  List<bool> isNotifiedEdited = [true, true, true, true];
  List<bool> isScheduleNotified = [true, true, true, true, true];

  @override
  void initState() {
    super.initState();

    isNotified = SharedPreference.getNotified();
    isNotifiedEdited[0] = SharedPreference.getNotifiedDelayed();
    isNotifiedEdited[1] = SharedPreference.getNotifiedCancelled();
    isNotifiedEdited[2] = SharedPreference.getNotifiedTransferred();
    isNotifiedEdited[3] = SharedPreference.getNotifiedDDay();
    isScheduleNotified[0] = SharedPreference.getNotified1DayBefore();
    isScheduleNotified[1] = SharedPreference.getNotified2DayBefore();
    isScheduleNotified[2] = SharedPreference.getNotified3DayBefore();
    isScheduleNotified[3] = SharedPreference.getNotified5DayBefore();
    isScheduleNotified[4] = SharedPreference.getNotified7DayBefore();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('ตั้งค่าการแจ้งเตือน'),
        centerTitle: true,
        toolbarHeight: size.height * 0.1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'NotoSansThai',
          fontWeight: FontWeight.w700,
          fontSize: size.width * 0.06,
          color: primaryColor,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SettingRow(
              'การแจ้งเตือน',
              isNotified,
              (val) async {
                await SharedPreference.setNotified(val);
                setState(() => isNotified = val);
              },
            ),
            isNotified
                ? Padding(
                    padding: EdgeInsets.only(top: size.width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SettingTopic('การแก้ไขนัดหมาย'),
                        _SettingRow(
                          'เมื่อการนัดหมายถูกเลื่อน',
                          isNotifiedEdited[0],
                          (val) async {
                            await SharedPreference.setNotifiedDelayed(val);
                            setState(() => isNotifiedEdited[0] = val);
                          },
                        ),
                        _SettingRow(
                          'เมื่อการนัดหมายถูกยกเลิก',
                          isNotifiedEdited[1],
                          (val) async {
                            await SharedPreference.setNotifiedCancelled(val);
                            setState(() => isNotifiedEdited[1] = val);
                          },
                        ),
                        _SettingRow(
                          'เมื่อมีการโอนถ่ายแพทย์',
                          isNotifiedEdited[2],
                          (val) async {
                            await SharedPreference.setNotifiedTransferred(val);
                            setState(() => isNotifiedEdited[2] = val);
                          },
                        ),
                        // _SettingRow(
                        //   'เมื่อถึงวันนัดหมาย',
                        //   isNotifiedEdited[3],
                        //   (val) async {
                        //     await SharedPreference.setNotifiedDDay(val);
                        //     setState(() => isNotifiedEdited[3] = val);
                        //   },
                        // ),
                      ],
                    ),
                  )
                : SizedBox(
                    width: 0,
                    height: 0,
                  ),
            // isNotified
            //     ? Padding(
            //         padding: EdgeInsets.only(top: size.width * 0.05),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             _SettingTopic('การแจ้งเตือนนัดหมายล่วงหน้า'),
            //             _SettingRow(
            //               '1 วันก่อนวันนัดหมาย',
            //               isScheduleNotified[0],
            //               (val) async {
            //                 await SharedPreference.setNotified1DayBefore(val);
            //                 setState(() => isScheduleNotified[0] = val);
            //               },
            //             ),
            //             _SettingRow(
            //               '2 วันก่อนวันนัดหมาย',
            //               isScheduleNotified[1],
            //               (val) async {
            //                 await SharedPreference.setNotified2DayBefore(val);
            //                 setState(() => isScheduleNotified[1] = val);
            //               },
            //             ),
            //             _SettingRow(
            //               '3 วันก่อนวันนัดหมาย',
            //               isScheduleNotified[2],
            //               (val) async {
            //                 await SharedPreference.setNotified3DayBefore(val);
            //                 setState(() => isScheduleNotified[2] = val);
            //               },
            //             ),
            //             _SettingRow(
            //               '5 วันก่อนวันนัดหมาย',
            //               isScheduleNotified[3],
            //               (val) async {
            //                 await SharedPreference.setNotified5DayBefore(val);
            //                 setState(() => isScheduleNotified[3] = val);
            //               },
            //             ),
            //             _SettingRow(
            //               '7 วันก่อนวันนัดหมาย',
            //               isScheduleNotified[4],
            //               (val) async {
            //                 await SharedPreference.setNotified7DayBefore(val);
            //                 setState(() => isScheduleNotified[4] = val);
            //               },
            //             ),
            //           ],
            //         ),
            //       )
            //     : SizedBox(
            //         width: 0,
            //         height: 0,
            //       ),
          ],
        ),
      ),
    );
  }

  Widget _SettingTopic(String text) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.grey),
        ),
        Divider(
          thickness: 1,
          height: size.width * 0.02,
        ),
      ],
    );
  }

  Widget _SettingRow(
    String text,
    bool value,
    Function(bool) onSwitched,
  ) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: size.width * 0.042),
        ),
        Switch(
          activeColor: primaryColor,
          value: value,
          onChanged: onSwitched,
        )
      ],
    );
  }
}
