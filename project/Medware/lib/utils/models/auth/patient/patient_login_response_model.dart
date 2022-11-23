import 'dart:convert';

PatientLoginResponseModel patientLoginResponseJson(String str) =>
    PatientLoginResponseModel.fromJson(json.decode(str));

class PatientLoginResponseModel {
  PatientLoginResponseModel({
    required this.payload,
    required this.statusCode,
    required this.statusText,
  });
  late final Payload payload;
  late final String statusCode;
  late final String statusText;

  PatientLoginResponseModel.fromJson(Map<String, dynamic> json) {
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
  Payload({
    required this.patientBloodType,
    required this.patientPhoneNumber,
    required this.patientLocation,
    required this.patientFirstName,
    required this.patientGender,
    required this.authtoken,
    required this.patientId,
    required this.patientMiddleName,
    required this.patientNationalId,
    required this.patientBirthDate,
    required this.patientLastName,
  });
  late final String patientBloodType;
  late final String patientPhoneNumber;
  late final String patientLocation;
  late final String patientFirstName;
  late final String patientGender;
  late final String authtoken;
  late final String patientId;
  late final String patientMiddleName;
  late final String patientNationalId;
  late final String patientBirthDate;
  late final String patientLastName;

  Payload.fromJson(Map<String, dynamic> json) {
    patientBloodType = json['patientBloodType'];
    patientPhoneNumber = json['patientPhoneNumber'];
    patientLocation = json['patientLocation'];
    patientFirstName = json['patientFirstName'];
    patientGender = json['patientGender'];
    authtoken = json['authtoken'];
    patientId = json['patientId'];
    patientMiddleName = json['patientMiddleName'];
    patientNationalId = json['patientNationalId'];
    patientBirthDate = json['patientBirthDate'];
    patientLastName = json['patientLastName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['patientBloodType'] = patientBloodType;
    _data['patientPhoneNumber'] = patientPhoneNumber;
    _data['patientLocation'] = patientLocation;
    _data['patientFirstName'] = patientFirstName;
    _data['patientGender'] = patientGender;
    _data['authtoken'] = authtoken;
    _data['patientId'] = patientId;
    _data['patientMiddleName'] = patientMiddleName;
    _data['patientNationalId'] = patientNationalId;
    _data['patientBirthDate'] = patientBirthDate;
    _data['patientLastName'] = patientLastName;
    return _data;
  }
}
