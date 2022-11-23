import 'package:medware/utils/models/appointment/all_schedules.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Allschedules>> getAllSchedule() async {

  var url = "https://medware1.herokuapp.com/schedules";

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'authtoken':
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVc2VyIERldGFpbHMiLCJpc3MiOiJjb2RlcGVuZGEiLCJleHAiOjE2NjkwOTk4MTksImlhdCI6MTY2OTA5NjgxOSwiYXV0aElkIjoiMTIzNDU2Nzg5MTIzNSJ9.Kiwxigxn2VtoBAYdUf6hMnVHE-jKKciTPGS9GXqjMsw'
  };

  try {
    var response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes);
      final _getdata = allschedulesFromJson(responseString);
      return _getdata;
    } else {
      throw Exception('Failed to load');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
