import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medware/utils/shared_preference/temp_auth_token.dart';

Future<http.Response> ConfirmTransfer(
  String scheduleId,
  String scheduleStatus,
  String appointmentDoctorId,
) async {
  final msg = jsonEncode({
    "scheduleId": "${scheduleId}",
    "scheduleStatus": "${scheduleStatus}",
    "appointmentDoctorId": "${appointmentDoctorId}",
  });
  var url = "https://medware1.herokuapp.com/schedules/update";
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    "content-type": "application/json",
    'authtoken': authToken,
  };
  try {
    var response =
        await http.put(Uri.parse(url), headers: requestHeaders, body: msg);
    if (response.statusCode == 200) {
      print("Update Success");
    } else {
      print(response.body);
    }
    return response;
  } catch (e) {
    throw Exception(e.toString());
  }
}
