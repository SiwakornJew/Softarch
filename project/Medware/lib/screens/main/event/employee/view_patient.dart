import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import "package:medware/utils/api/appointment/get_employee_appointment_by_id.dart";
import 'package:medware/utils/models/event/getPatientAppointment.dart';
import 'package:medware/utils/statics.dart';

class PatientView extends StatefulWidget {
  final int id;
  const PatientView({super.key, required this.id});

  @override
  State<PatientView> createState() => _PatientViewState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _PatientViewState extends State<PatientView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _debouncer = Debouncer();

  List<GetPatientAppointment> ulist = [];
  List<GetPatientAppointment> userLists = [];

  @override
  void initState() {
    super.initState();
    getPatientOnSchedule(widget.id.toString()).then((subjectFromServer) {
      setState(() {
        ulist = subjectFromServer;
        userLists = ulist;
      });
    });
    //getPatientOnSchedule(widget.id.toString());
  }

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
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
          ],
        ),
        title: SizedBox(
          width: size.width * 0.67,
          child: Text('คนไข้ในรอบนี้',
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
          child: RefreshIndicator(
        onRefresh: () => getPatientOnSchedule(widget.id.toString()),
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        backgroundColor: quaternaryColor,
        color: primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(mainAxisSize: MainAxisSize.max, children: []),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        size.width * 0.05,
                        size.width * 0.05,
                        size.width * 0.05,
                        size.width * 0.05),
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: "ค้นหาคนไข้",
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(size.shortestSide * 0.05),
                            borderSide: BorderSide(color: primaryColor),
                          )),
                      onChanged: (string) {
                        _debouncer.run(() {
                          setState(() {
                            userLists = ulist
                                .where((u) =>
                                    (u.patientFirstName.contains(
                                      string,
                                    )) ||
                                    (u.patientMiddleName.contains(
                                      string,
                                    )) ||
                                    (u.patientLastName.contains(
                                      string,
                                    )))
                                .toList();
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: userLists.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: EdgeInsetsDirectional.fromSTEB(size.width*0.03,size.width*0.04,size.width*0.03,0),
                          decoration: BoxDecoration(
                        color: quaternaryColor,
                        borderRadius:
                            BorderRadius.circular(size.width * 0.03),
                          ),
                          child: ListTile(
                        onTap: () {},
                        title: Text(
                            "${userLists[i].patientFirstName} ${userLists[i].patientMiddleName} ${userLists[i].patientLastName}"),
                        leading: Icon(Icons.account_circle_rounded,
                            size: size.width * 0.08),
                          ),
                        );
                      }),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
