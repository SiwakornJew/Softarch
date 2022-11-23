import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medware/screens/main/main_screen.dart';
import 'package:medware/utils/api/event/comfirm_delay_employee.dart';
import 'package:medware/utils/api/event/confirm_delay_patient.dart';
import 'package:medware/utils/api/notification/push_notification.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';
import 'package:medware/utils/statics.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConfirmDelayPatientAppointment extends StatefulWidget {
  final DateTime scheduleDate;
  final DateTime scheduleStart;
  final DateTime scheduleEnd;
  final int previousScheduleId;
  final int toScheduleId;
  final int patientNationalId;

  const ConfirmDelayPatientAppointment({
    super.key,
    required this.scheduleDate,
    required this.scheduleStart,
    required this.scheduleEnd,
    required this.previousScheduleId,
    required this.toScheduleId,
    required this.patientNationalId,
  });

  @override
  State<ConfirmDelayPatientAppointment> createState() =>
      _ConfirmDelayPatientAppointmentState();
}

class _ConfirmDelayPatientAppointmentState
    extends State<ConfirmDelayPatientAppointment> {
  void listenToNotificationStream() async {
    PushNotification.onClickNotifications.stream.listen(
      (payload) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    listenToNotificationStream();
  }

/*
    "scheduleId" : "1",
    "scheduleCapacity" : "10", 
    "scheduleStart" : "2022-11-21T09:00:00",
    "scheduleEnd" : "2022-11-21T012:00:00",
    "scheduleDate" : "2022-11-21",
    "scheduleLocation" : "location02",
    "scheduleStatus" : "true",
    "appointmentDoctorId" : "2"
*/
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final MonthDateFormatter = DateFormat.MMMM();
    final YearDateFormatter = DateFormat.y();
    final DateDateFormatter = DateFormat.d();
    final timeFormatter = DateFormat.jm();
    final timeFormatterForApi = DateFormat("yyyy-MM-ddTHH:mm:ss");
    final dateFormatter = DateFormat('d MMMM y');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: GestureDetector(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: size.height * 0.2666,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(size.width, 70)),
                gradient: RadialGradient(
                  colors: [tertiaryColor, quaternaryColor],
                  center: Alignment.topRight,
                  radius: size.width * 0.005,
                  focal: Alignment.topRight,
                  focalRadius: size.width * 0.001,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        size.width * 0.055, size.height * 0.068, 0, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        size.width * 0.02, 0, 0, 0),
                                    child: Icon(Icons.arrow_back_ios,
                                        size: size.width * 0.04,
                                        color: primaryColor),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        size.width * 0.01, 0, 0, 0),
                                    child: Text('กลับ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'NotoSansThai',
                                          fontWeight: FontWeight.w400,
                                          fontSize: size.width * 0.046,
                                          color: primaryColor,
                                        )),
                                  )
                                ],
                              )),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, size.height * 0.027, 0, 0),
                    child: Center(
                      child: Text('ยืนยันการนัดหมาย',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'NotoSansThai',
                            fontWeight: FontWeight.w700,
                            fontSize: size.width * 0.1,
                            color: primaryColor,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(size.width * 0.06,
                    size.width * 0.06, size.width * 0.06, size.width * 0.06),
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.09,
                  decoration: BoxDecoration(
                    color: quaternaryColor,
                    borderRadius: BorderRadius.circular(size.width * 0.05),
                  ),
                  child: Center(
                      child: Text(
                    "ตรวจสุขภาพ",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.065,
                    ),
                  )),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(size.width * 0.06,
                    size.width * 0.04, size.width * 0.06, size.width * 0.06),
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.18,
                  decoration: BoxDecoration(
                    color: quaternaryColor,
                    borderRadius: BorderRadius.circular(size.width * 0.05),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: size.width * 0.02),
                            child: Icon(
                              Icons.date_range,
                              size: size.width * 0.1,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            'วันที่',
                            style: TextStyle(
                              color: Color.fromARGB(115, 28, 103, 88),
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.04,
                            ),
                          ),
                          Text(
                            '${DateDateFormatter.format(widget.scheduleDate)}' +
                                ' '
                                    '${MonthDateFormatter.format(widget.scheduleDate)}' +
                                ' ' +
                                '${YearDateFormatter.format(widget.scheduleDate)}',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.045,
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: primaryColor,
                        width: 5,
                        thickness: 1,
                        indent: size.height * 0.02,
                        endIndent: size.height * 0.02,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: size.width * 0.02),
                            child: Icon(
                              Icons.access_time,
                              size: size.width * 0.1,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            'เวลา',
                            style: TextStyle(
                              color: Color.fromARGB(115, 28, 103, 88),
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.04,
                            ),
                          ),
                          Text(
                            '${timeFormatter.format(widget.scheduleStart)} - ${timeFormatter.format(widget.scheduleEnd)}',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.045,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(size.width * 0.06, size.width * 0.04,
                  size.width * 0.06, size.width * 0.06),
              child: Container(
                width: double.infinity,
                height: size.height * 0.18,
                decoration: BoxDecoration(
                  color: quaternaryColor,
                  borderRadius: BorderRadius.circular(size.width * 0.05),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(top: size.width * 0.04),
                      child: Icon(
                        Icons.medical_services,
                        size: size.width * 0.1,
                        color: primaryColor,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(top: size.width * 0.04),
                      child: Text(
                        "คนไข้",
                        style: TextStyle(
                          color: Color.fromARGB(115, 28, 103, 88),
                          fontWeight: FontWeight.w400,
                          fontSize: size.width * 0.035,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "จำนวน 5 คน",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.048,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  print(widget.previousScheduleId.toString());
                  print(widget.toScheduleId.toString());
                  print(widget.patientNationalId.toString());
                  await ConfirmDelayPatient(
                      widget.previousScheduleId.toString(),
                      widget.toScheduleId.toString(),
                      widget.patientNationalId.toString());

                  (SharedPreference.getNotified() &&
                          SharedPreference.getNotifiedDelayed())
                      ? PushNotification.showNotification(
                          title: 'มีการเลื่อนนัดหมายของคุณ',
                          body:
                              'การนัดหมายการในวันที่ ${dateFormatter.format(widget.scheduleDate)} เวลา ${timeFormatter.format(widget.scheduleStart)} - ${timeFormatter.format(widget.scheduleEnd)} ถูกเลื่อนออกไปแล้ว',
                          id: widget.toScheduleId,
                        )
                      : null;
                  await Future.delayed(const Duration(seconds: 1));
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: quaternaryColor,
                ),
                child: Text(
                  "ยืนยัน",
                  style: TextStyle(color: primaryColor),
                ))
          ],
        ),
      )),
    );
  }
}
