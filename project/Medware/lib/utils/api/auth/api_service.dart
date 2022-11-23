import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medware/utils/api/auth/config.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';
import 'package:medware/utils/shared_preference/temp_auth_token.dart';
import '../../models/auth/employee/employee_login_request_model.dart';
import '../../models/auth/employee/employee_login_response_model.dart';
import '../../models/auth/employee/employee_register_request_model.dart';
import '../../models/auth/employee/employee_register_response_model.dart';
import '../../models/auth/patient/paitent_login_request_model.dart';
import '../../models/auth/patient/patient_login_response_model.dart';
import '../../models/auth/patient/patient_register_request_model.dart';
import '../../models/auth/patient/patient_register_response_model.dart';

class APIService {
  static var client = http.Client();

  //Patient
  static Future<PatientLoginResponseModel> patientLogin(
    PatientLoginRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };

    var url = Uri.http(
      Config.apiURL,
      Config.patientLoginAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return patientLoginResponseJson(
      utf8.decode(response.bodyBytes),
    );
  }

  static Future<PatientRegisterResponseModel> patientRegister(
    PatientRegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.patientRegisterAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return patientRegisterResponseJson(
      utf8.decode(response.bodyBytes),
    );
  }

  //Employee
  static Future<EmployeeLoginResponseModel> employeeLogin(
    EmployeeLoginRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.employeeLoginAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return employeeLoginResponseJson(
      utf8.decode(response.bodyBytes),
    );
  }

  static Future<EmployeeRegisterResponseModel> employeeRegister(
    EmployeeRegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authToken': authToken,
    };

    var url = Uri.http(
      Config.apiURL,
      Config.employeeRegisterAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return employeeRegisterResponseJson(
      utf8.decode(response.bodyBytes),
    );
  }
}
