import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medware/utils/models/event/getPatientAppointment.dart';
import 'package:medware/utils/shared_preference/temp_auth_token.dart';

Future<List<GetPatientAppointment>> getPatientOnSchedule(
    String scheduleId) async {
  var url = "https://medware1.herokuapp.com/appointments/findPatientbyScheduleId/${scheduleId}";

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'authtoken': authToken
  };

  try {
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes);
      final _getdata = getPatientAppointmentFromJson(responseString);

      return _getdata;
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
