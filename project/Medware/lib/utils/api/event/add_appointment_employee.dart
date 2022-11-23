import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:medware/components/snackbar.dart';
import 'package:medware/utils/shared_preference/temp_auth_token.dart';

Future ConfirmAdd(
    String scheduleId, String patientNationalId, BuildContext _context) async {
  final msg = jsonEncode({
    "scheduleId": "${scheduleId}",
    "patientNationalId": "${patientNationalId}"
  });

  var url = "https://medware1.herokuapp.com/appointments/createNewAppointment";

  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    "content-type": "application/json",
    'authtoken': authToken
  };
  try {
    var response =
        await http.post(Uri.parse(url), headers: requestHeaders, body: msg);
    print(msg);
    if (response.statusCode == 200) {
      SnackBar_show.buildSuccessSnackbar(_context, "สร้างตารางเวลาเสร็จสิ้น");
    } else {
      print(response.statusCode);
      if (response.body == "Exception: Auth Time Out") {
        SnackBar_show.buildErrorSnackbar(_context, "มีปัญหา");
      }
      if (response.body == "Exception: Auth Time Out") {
        SnackBar_show.buildErrorSnackbar(_context, "มีปัญหา");
      } else if (response.body == "Exception: Patient Busy") {
        SnackBar_show.buildErrorSnackbar(_context, "คนไข้ไม่ว่างในตอนนี้");
      } else if (response.body.contains("is already in schedule")) {
        SnackBar_show.buildErrorSnackbar(_context, "คนไข้ไม่ว่างในตอนนี้");
      } else if (response.body.contains("Can't Appointment before")) {
        SnackBar_show.buildErrorSnackbar(
            _context, "ไม่สามารถสร้างนัดได้ก่อนภายในสามวัน");
      } else {
        SnackBar_show.buildErrorSnackbar(_context, "เกิดปัญหา ลองใหม่อีกครั้ง");
      }
    }
  } on Exception catch (e) {
    print(e);
  }
}
