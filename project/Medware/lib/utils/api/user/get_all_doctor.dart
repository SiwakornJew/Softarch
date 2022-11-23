import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medware/utils/shared_preference/temp_auth_token.dart';

import '../../models/user/all_doctor.dart';

Future<List<AllDoctor>> getAllDoctor() async {
  var url = "https://medware1.herokuapp.com/employee/getdoctor";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',

    'authtoken': authToken
  };
  try {
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes);
      final _getdata = allDoctorFromJson(responseString);
      
      print(response.statusCode);

      return _getdata;
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
