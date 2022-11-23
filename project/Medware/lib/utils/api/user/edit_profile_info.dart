import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medware/utils/shared_preference/shared_preference.dart';
import 'package:medware/utils/statics.dart';

Future<http.Response> editProfileInfo({
  required int id,
  String? newPassword,
  String? medicalDetailType,
  String? medicalDetails,
  int? profileIndex,
}) async {
  final int role = SharedPreference.getUserRole();

  final String url = role == 0
      ? '${baseUrl}/employee/update/${id}'
      : '${baseUrl}/updatePatient/${id}';

  String body = '';
  if (newPassword != null) {
    role == 0
        ? body = json.encode({
            'employeePassword': newPassword,
          })
        : body = json.encode({
            'patientPassword': newPassword,
          });
  } else if (medicalDetailType == 'โรคประจำตัว') {
    body = json.encode({
      'patientDisease': medicalDetails,
    });
  } else if (medicalDetailType == 'การแพ้ยา') {
    body = json.encode({
      'patientMedicine': medicalDetails,
    });
  } else if (medicalDetailType == 'ภูมิแพ้') {
    body = json.encode({
      'patientAllergy': medicalDetails,
    });
  } else if (profileIndex != null) {
    body = json.encode({
      'patientProfileIndex': profileIndex,
    });
  }

  try {
    var response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    print(response.body);
    return response;
  } catch (e) {
    throw Exception(e.toString());
  }
}
