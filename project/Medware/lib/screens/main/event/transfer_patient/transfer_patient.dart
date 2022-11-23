import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:medware/utils/statics.dart';

import 'package:medware/screens/main/event/transfer_patient/confirm_transfer_patient.dart';
import 'package:medware/utils/api/user/get_all_doctor.dart';
import 'package:medware/utils/models/user/all_doctor.dart';



class TransferPatient extends StatefulWidget {
  final int scheduleId;
  final DateTime scheduleDate;
  final DateTime scheduleEnd;
  final DateTime scheduleStart;

  getId() {
    return scheduleId;
  }

  const TransferPatient({
    super.key,
    required this.scheduleId,
    required this.scheduleDate,
    required this.scheduleEnd,
    required this.scheduleStart,
  });

  @override
  State<TransferPatient> createState() => _TransferPatientState();
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

class _TransferPatientState extends State<TransferPatient> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _debouncer = Debouncer();

  List<AllDoctor> ulist = [];
  List<AllDoctor> userLists = [];

  late List<AllDoctor> _getdata;

  @override
  void initState() {
    super.initState();
    getAllDoctor().then((subjectFromServer) {
      setState(() {
        ulist = subjectFromServer;
        userLists = ulist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final id = widget.scheduleId;
    final date = widget.scheduleDate;
    final timeStart = widget.scheduleStart;
    final timeEnd = widget.scheduleEnd;

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
                        padding:
                            EdgeInsets.fromLTRB(size.width * 0.07, 0, 0, 0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: size.width * 0.04,
                          color: primaryColor,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(size.width * 0.01, 0, 0, 0),
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
            child: Text('เลือกแพทย์',
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
            child: RefreshIndicator(
              onRefresh: getAllDoctor,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              backgroundColor: quaternaryColor,
              color: primaryColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
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
                              hintText: "ค้นหาแพทย์",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    size.shortestSide * 0.05),
                                borderSide: BorderSide(color: primaryColor),
                              )),
                          onChanged: (string) {
                            _debouncer.run(() {
                              setState(() {
                                userLists = ulist
                                    .where((u) =>
                                        (u.employeeFirstName.contains(
                                          string,
                                        )) ||
                                        (u.employeeMiddleName.contains(
                                          string,
                                        )) ||
                                        (u.employeeLastName.contains(
                                          string,
                                        )) ||
                                        (u.employeeId.toString().contains(
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
                        physics: ScrollPhysics(parent: null),
                        shrinkWrap: true,
                        itemCount: userLists.length,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: EdgeInsetsDirectional.fromSTEB(
                                size.width * 0.03,
                                size.width * 0.04,
                                size.width * 0.03,
                                0),
                            decoration: BoxDecoration(
                              color: quaternaryColor,
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.03),
                            ),
                            child: GestureDetector(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ConfirmTransferPatient(
                                        scheduleId: id,
                                        scheduleDate: date,
                                        scheduleEnd: timeEnd,
                                        scheduleStart: timeStart,
                                        appointmentDoctorId:
                                            userLists[i].employeeId,
                                        scheduleLocation: 'โรงบาลลาดกระบัง',
                                        scheduleStatus: true, 
                                        doctorFirstName: userLists[i].employeeFirstName,
                                        doctorMiddleName: userLists[i].employeeMiddleName,
                                        doctorLastName: userLists[i].employeeLastName,
                                      ),
                                    ),
                                  );
                                },
                                title: Text(
                                    "${userLists[i].employeeFirstName} ${userLists[i].employeeMiddleName} ${userLists[i].employeeLastName}"),
                                trailing: Icon(Icons.arrow_forward_ios),
                                leading: Icon(Icons.account_circle_rounded,
                                    size: size.width * 0.08),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}
