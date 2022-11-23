import 'dart:convert';

EmployeeLoginResponseModel employeeLoginResponseJson(String str) =>
    EmployeeLoginResponseModel.fromJson(json.decode(str));

class EmployeeLoginResponseModel {
  EmployeeLoginResponseModel({
    required this.payload,
    required this.statusCode,
    required this.statusText,
  });
  late final Payload payload;
  late final String statusCode;
  late final String statusText;

  EmployeeLoginResponseModel.fromJson(Map<String, dynamic> json) {
    payload = Payload.fromJson(json['payload']);
    statusCode = json['statusCode'];
    statusText = json['statusText'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['payload'] = payload.toJson();
    _data['statusCode'] = statusCode;
    _data['statusText'] = statusText;
    return _data;
  }
}

class Payload {
  Payload(
      {required this.employeePhoneNumber,
      required this.employeeFirstName,
      required this.employeeGender,
      required this.authtoken,
      required this.employeeId,
      required this.employeeMiddleName,
      required this.employeeNationalId,
      required this.employeeLastName,
      required this.isAdmin});
  late final String employeePhoneNumber;
  late final String employeeFirstName;
  late final String employeeGender;
  late final String authtoken;
  late final String employeeId;
  late final String employeeMiddleName;
  late final String employeeNationalId;
  late final String employeeLastName;
  late final bool isAdmin;

  Payload.fromJson(Map<String, dynamic> json) {
    employeePhoneNumber = json['employeePhoneNumber'];
    employeeFirstName = json['employeeFirstName'];
    employeeGender = json['employeeGender'];
    authtoken = json['authtoken'];
    employeeId = json['employeeId'];
    employeeMiddleName = json['employeeMiddleName'];
    employeeNationalId = json['employeeNationalId'];
    employeeLastName = json['employeeLastName'];
    isAdmin = json['employeeIsAdmin'] == 'true';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['employeePhoneNumber'] = employeePhoneNumber;
    _data['employeeFirstName'] = employeeFirstName;
    _data['employeeGender'] = employeeGender;
    _data['authtoken'] = authtoken;
    _data['employeeId'] = employeeId;
    _data['employeeMiddleName'] = employeeMiddleName;
    _data['employeeNationalId'] = employeeNationalId;
    _data['employeeLastName'] = employeeLastName;
    _data['isAdmin'] = isAdmin;
    return _data;
  }
}
