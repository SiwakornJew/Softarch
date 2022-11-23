import 'dart:convert';

EmployeeRegisterResponseModel employeeRegisterResponseJson(String str) =>
    EmployeeRegisterResponseModel.fromJson(json.decode(str));

class EmployeeRegisterResponseModel {
  EmployeeRegisterResponseModel({
    required this.payload,
    required this.statusCode,
    required this.statusText,
  });
  late final Payload? payload;
  late final String statusCode;
  late final String statusText;

  EmployeeRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    statusCode = json['statusCode'];
    statusText = json['statusText'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['payload'] = payload!.toJson();
    _data['statusCode'] = statusCode;
    _data['statusText'] = statusText;
    return _data;
  }
}

class Payload {
  Payload();

  Payload.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}
