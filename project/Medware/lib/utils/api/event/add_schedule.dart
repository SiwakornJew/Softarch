import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medware/components/snackbar.dart';
import 'package:medware/utils/shared_preference/temp_auth_token.dart';

Future ConfirmAddSchedule(
  String scheduleCapacity,
  String scheduleStart,
  String scheduleEnd,
  String scheduleDate,
  String scheduleLocation,
  String employeeId,
  String scheduleType,
  BuildContext _context,
) async {
  final msg = jsonEncode({
    "scheduleCapacity": "${scheduleCapacity}",
    "scheduleStart": "${scheduleStart}",
    "scheduleEnd": "${scheduleEnd}",
    "scheduleDate": "${scheduleDate}",
    "scheduleLocation": "${scheduleLocation}",
    "employeeId": "${employeeId}",
    "scheduleType": "${scheduleType}",
  });

  print(msg);

  var url = "https://medware1.herokuapp.com/schedules/createNewSchedule";

  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    "content-type": "application/json",
    'authtoken': authToken
  };
  try {
    var response =
        await http.post(Uri.parse(url), headers: requestHeaders, body: msg);
    if (response.statusCode == 200) {
      print("Create Success");

      SnackBar_show.buildSuccessSnackbar(_context, "สร้างตารางเวลาเสร็จสิ้น");
    } else {
      throw Exception(response.body);
    }
  } on Exception catch (e) {
    if (e.toString() == "Exception: Auth Time Out") {
      SnackBar_show.buildErrorSnackbar(_context, "มีปัญหา");
    } else if (e.toString() == "Exception: Employee Busy") {
      SnackBar_show.buildErrorSnackbar(
          _context, "ผู้ใช้ไม่มีเวลาว่างในขณะนั้น");
    } else if (e
        .toString()
        .contains("Exception: Location is taken at that time")) {
      SnackBar_show.buildErrorSnackbar(_context, "สถานที่ถูกใช้ไปแล้ว");
    }
  }
}
