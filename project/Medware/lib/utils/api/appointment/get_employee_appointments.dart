import 'dart:convert';
import 'package:medware/utils/models/appointment/employee_appointment.dart';
import 'package:http/http.dart' as http;
import 'package:medware/utils/statics.dart';

Future<List<EmployeeAppointment>> getEmployeeAppointments(int id) async {
  final url = '${baseUrl}/getappointmentbyEmployee/${id}';

  try {
    var results = await http.get(Uri.parse(url));
    if (results.statusCode == 200) {
      print(json.decode(utf8.decode(results.bodyBytes)));
      var res = json
          .decode(utf8.decode(results.bodyBytes))
          .map<EmployeeAppointment>(EmployeeAppointment.fromJson)
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
