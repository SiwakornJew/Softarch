import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medware/utils/shared_preference/temp_auth_token.dart';

Future ConfirmDelayPatient(
  String previousScheduleId,
  String toScheduleId,
  String patientNationalId,
) async {
  final msg = jsonEncode({
    "previousScheduleId": "${previousScheduleId}",
    "toScheduleId": "${toScheduleId}",
    "patientNationalId": "${patientNationalId}",
  });

  var url = "https://medware1.herokuapp.com/patient/postponeAppointment";
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    "content-type": "application/json",
    'authtoken': authToken,
  };
  try {
    var response =
        await http.post(Uri.parse(url), headers: requestHeaders, body: msg);
    if (response.statusCode == 200) {
      print("Update Success");
    } else {
      print(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
