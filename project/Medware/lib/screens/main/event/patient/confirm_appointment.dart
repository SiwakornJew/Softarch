import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medware/utils/statics.dart';
import 'package:medware/utils/api/event/patient/create_appointment.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';
import 'package:medware/utils/statics.dart' as statics;

class ConfirmAppointment extends StatelessWidget {
  final int id;
  final int capacity;
  final int patientCount;
  final int type;
  final int department;
  final DateTime date;
  final DateTime startTime;
  final DateTime finishTime;
  final String doctorFirstName;
  final String doctorMiddleName;
  final String doctorLastName;
  const ConfirmAppointment(
      {required this.id,
      required this.capacity,
      required this.patientCount,
      required this.date,
      required this.startTime,
      required this.finishTime,
      required this.type,
      required this.doctorFirstName,
      required this.doctorMiddleName,
      required this.doctorLastName,
      required this.department});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final MonthDateFormatter = DateFormat.MMMM();
    final YearDateFormatter = DateFormat.y();
    final DayDateFormatter = DateFormat.d();
    final timeFormatter = DateFormat.jm();

    String _DoctorName(String firstName, String middleName, String LastName) {
      if (middleName == null) {
        return firstName + ' ' + LastName;
      } else {
        return firstName + ' ' + middleName + ' ' + LastName;
      }
    }

    _showAlertDialog(BuildContext context, int status) {
      print('schedule : ' + id.toString());
      print('User National id : ' +
          SharedPreference.getUserNationalId().toString());
      Widget okButton = TextButton(
        child: Text(
          'OK',
          style: TextStyle(
              fontFamily: 'NotoSansThai',
              fontWeight: FontWeight.w800,
              fontSize: size.width * 0.04,
              color: tertiaryColor),
        ),
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      );

      AlertDialog alert = AlertDialog(
        title: status == 200
            ? Text(
                'การจองของท่านเสร็จสิ้น',
                style: TextStyle(
                    fontFamily: 'NotoSansThai',
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.06,
                    color: primaryColor),
              )
            : Text(
                'การจองของท่านไม่สำเร็จ',
                style: TextStyle(
                    fontFamily: 'NotoSansThai',
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.06,
                    color: primaryColor),
              ),
        content: status == 200
            ? Text('ท่านสามารถแก้นัดไขการนัดหมายได้ก่อนถึงวันนัดหมาย 3 วัน',
                style: TextStyle(
                    fontFamily: 'NotoSansThai',
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * 0.04,
                    color: secondaryColor))
            : Text(
                'โปรดตรวจสอบให้แน่ใจว่าท่านไม่ได้ทำรายการซ้ำ แล้วลองทำรายการใหม่อีกครั้ง',
                style: TextStyle(
                    fontFamily: 'NotoSansThai',
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * 0.04,
                    color: secondaryColor),
              ),
        actions: [
          okButton,
        ],
      );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: size.height * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: size.height * 0.2666,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(size.width, 70)),
                gradient: RadialGradient(
                  colors: [primaryColor, secondaryColor],
                  center: Alignment.topRight,
                  radius: size.width * 0.0025,
                  focal: Alignment.topRight,
                  focalRadius: size.width * 0.0007,
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
                                        color: Color(0xFFEEF2E6)),
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
                                          color: Color(0xFFEEF2E6),
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
                            color: Color(0xFFEEF2E6),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06,
              ),
              child: Container(
                width: double.infinity,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: quaternaryColor,
                  borderRadius: BorderRadius.circular(size.width * 0.05),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          statics.appointmentTypes[type],
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: size.width * 0.068,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06,
              ),
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
                          '${DayDateFormatter.format(date)}' +
                              ' '
                                  '${MonthDateFormatter.format(date)}' +
                              ' ' +
                              '${YearDateFormatter.format(date)}',
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
                          '${timeFormatter.format(startTime)} - ${timeFormatter.format(finishTime)}',
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
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                ),
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.22,
                  decoration: BoxDecoration(
                    color: quaternaryColor,
                    borderRadius: BorderRadius.circular(size.width * 0.05),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.medical_services,
                        size: size.width * 0.1,
                        color: primaryColor,
                      ),
                      Column(
                        children: [
                          Text(
                            'แพทย์',
                            style: TextStyle(
                              color: Color.fromARGB(115, 28, 103, 88),
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.035,
                            ),
                          ),
                          Text(
                            _DoctorName(doctorFirstName, doctorMiddleName,
                                doctorLastName),
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: size.width * 0.048,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'แผนก',
                            style: TextStyle(
                              color: Color.fromARGB(115, 28, 103, 88),
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.035,
                            ),
                          ),
                          Text(
                            statics.departments[department],
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: size.width * 0.048,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            Container(
              width: size.width * 0.25,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                color: quaternaryColor,
                borderRadius: BorderRadius.circular(size.width * 0.03),
              ),
              child: GestureDetector(
                onTap: () async {
                  var status = await createNewAppointment(id.toString(),
                      SharedPreference.getUserNationalId().toString());
                  _showAlertDialog(context, status);
                },
                child: Center(
                  child: InkWell(
                    child: Text(
                      'ยืนยัน',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: size.width * 0.038,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
