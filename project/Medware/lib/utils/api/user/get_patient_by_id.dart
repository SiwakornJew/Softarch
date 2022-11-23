import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medware/utils/models/user/patient.dart';
import 'package:medware/utils/statics.dart';

Future<Patient> getPatientById(int id) async {
  final url = '${baseUrl}/patientsinfo/findbyId/${id}';

  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var res = json.decode(utf8.decode(response.bodyBytes));
      return Patient.fromJson(res);
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
