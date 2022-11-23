import 'package:medware/utils/shared_preference/temp_auth_token.dart';

import '../../models/appointment/get_all_schedule.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Allschedules>> getAllSchedule() async {

  var url = "https://medware1.herokuapp.com/schedules";

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'authtoken': authToken,
  };

  try {
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes);
      final _getdata = allschedulesFromJson(responseString);
      return _getdata;
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    print(e);
    throw Exception(e.toString());
  }
}
