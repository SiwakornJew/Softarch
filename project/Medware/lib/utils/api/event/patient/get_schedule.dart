import 'package:medware/utils/models/event/patient/patient_event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<PatientEvent>> getPatientSchedule(int id) async {
  var url = 'https://medware1.herokuapp.com/getScheduleBytpye/${id}';
  var response;

  try {
    response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Call API Successfully.');
    } else {
      throw Exception(response.statusCode);
    }
  } on Exception catch (_error) {
    print(_error);
  } catch (_error) {
    print(_error);
  }
  return PatientEventFromJson(utf8.decode(response.bodyBytes));
}
