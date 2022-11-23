import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medware/utils/statics.dart';
import 'package:medware/screens/main/event/employee/create_appointment.dart'
    as create_appointment;
import 'package:medware/screens/main/event/employee/add_work_hours.dart'
    as add_work_hours;

class AppointmentTypeScreen extends StatefulWidget {
  const AppointmentTypeScreen({Key? key}) : super(key: key);

  @override
  AppointmentTypeScreenState createState() => AppointmentTypeScreenState();
}

class AppointmentTypeScreenState extends State<AppointmentTypeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child:Column(children: [
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
                              create_appointment.AppointmentDoctorCreate(),

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
                              child: Text('สร้างนัดกับคนไข้',
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
                              add_work_hours.addWorkHoursScreen(),
                        ),
                      );
                    },
                    child: Stack(children: [
                      Container(
                         margin:
                            EdgeInsets.fromLTRB(0, size.height * 0.012, 0, 0),
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
                              image: AssetImage('assets/images/schedule.png'),
                              height: size.height * 0.27,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0, size.height * 0, 0, 0),
                              child: Text('เพิ่มเวลาทำการ',
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
   ),
      ),
    );
  }
}
