import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medware/utils/statics.dart';
import 'package:medware/screens/main/event/patient/calendar_appointment.dart';

class EventTypePicker extends StatelessWidget {
  const EventTypePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        toolbarHeight: size.height * 0.1,
        backgroundColor: Colors.white,
        leadingWidth: size.width * 0.22,
        leading: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(size.width * 0.07, 0, 0, 0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: size.width * 0.04,
                      color: primaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(size.width * 0.01, 0, 0, 0),
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
        title: SizedBox(
          width: size.width * 0.67,
          child: Text('เลือกประเภทนัดหมาย',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'NotoSansThai',
                fontWeight: FontWeight.w700,
                fontSize: size.width * 0.072,
                color: primaryColor,
              )),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemStatusBarContrastEnforced: true,
        ),
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, size.height * 0.036, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  color: Colors.transparent,
                  height: size.height * 0.3537,
                  width: size.width * 0.81,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const CalendarAppointment(type: 2),
                        ),
                      );
                    },
                    child: Stack(children: [
                      Container(
                        margin:
                            EdgeInsets.fromLTRB(0, size.height * 0.032, 0, 0),
                        height: size.height * 0.33,
                        width: size.width * 0.81,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius:
                              BorderRadius.circular(size.height * 9 / 422),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1),
                              blurRadius: 20,
                              offset: Offset(5, 8),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              image:
                                  AssetImage('assets/images/appointment.png'),
                              height: size.height * 0.27,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0, size.height * 0.0133, 0, 0),
                              child: Text('ตรวจสุขภาพ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'NotoSansThai',
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.width * 0.061,
                                    color: Color(0xFFEEF2E6),
                                  )),
                            )
                          ],
                        ),
                      )
                    ]),
                  ))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, size.height * 0.036, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  color: Colors.transparent,
                  height: size.height * 0.33,
                  width: size.width * 0.81,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const CalendarAppointment(type: 3),
                        ),
                      );
                    },
                    child: Stack(children: [
                      Container(
                        height: size.height * 0.33,
                        width: size.width * 0.81,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius:
                              BorderRadius.circular(size.height * 9 / 422),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1),
                              blurRadius: 20,
                              offset: Offset(5, 8),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage('assets/images/blood.png'),
                              height: size.height * 0.27,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0, size.height * 0, 0, 0),
                              child: Text('บริจาคโลหิต',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'NotoSansThai',
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.width * 0.061,
                                    color: Color(0xFFEEF2E6),
                                  )),
                            )
                          ],
                        ),
                      )
                    ]),
                  ))
            ],
          ),
        ),
      ]),
    );
  }
}
