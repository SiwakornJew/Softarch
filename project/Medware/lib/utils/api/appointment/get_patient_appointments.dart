import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medware/utils/models/appointment/patient_appointment.dart';
import 'package:medware/utils/statics.dart';

Future<List<PatientAppointment>> getPatientAppointments(int id) async {
  final url = '${baseUrl}/getappointmentbyPatient/${id}';

  try {
    var results = await http.get(Uri.parse(url));
    print(json.decode(utf8.decode(results.bodyBytes)).length);
    if (results.statusCode == 200) {
      var res = json
          .decode(utf8.decode(results.bodyBytes))
          .map<PatientAppointment>(PatientAppointment.fromJson)
          .toList()
          .where((i) =>
              DateTime.parse(i.startTime.toString()).isAfter(DateTime.now()))
          .toList();
      res.sort((a, b) => DateTime.parse(a.startTime.toString())
          .compareTo(DateTime.parse(b.startTime.toString())));
      return res;
    } else {
      return [];
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
