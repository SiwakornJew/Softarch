// To parse this JSON data, do
//
//     final allDoctor = allDoctorFromJson(jsonString);

import 'dart:convert';

List<AllDoctor> allDoctorFromJson(String str) =>
    List<AllDoctor>.from(json.decode(str).map((x) => AllDoctor.fromJson(x)));

String allDoctorToJson(List<AllDoctor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllDoctor {
  AllDoctor({
    required this.employeeId,
    required this.employeeFirstName,
    required this.employeeMiddleName,
    required this.employeeLastName,
    required this.employeeNationalId,
    required this.employeeIsAdmin,
    required this.employeePhoneNumber,
    required this.employeeRole,
    required this.employeeDepartment,
    required this.employeePassword,
  });

  int employeeId;
  String employeeFirstName;
  String employeeMiddleName;
  String employeeLastName;
  String employeeNationalId;
  bool employeeIsAdmin;
  String employeePhoneNumber;
  int employeeRole;
  int employeeDepartment;
  String employeePassword;

  factory AllDoctor.fromJson(Map<String, dynamic> json) => AllDoctor(
        employeeId: json["employeeId"],
        employeeFirstName:
            json["employeeFirstName"] == null ? '' : json["employeeFirstName"],
        employeeMiddleName: json["employeeMiddleName"] == null
            ? ''
            : json["employeeMiddleName"],
        employeeLastName:
            json["employeeLastName"] == null ? '' : json["employeeLastName"],
        employeeNationalId: json["employeeNationalId"],
        employeeIsAdmin: json["employeeIsAdmin"],
        employeePhoneNumber: json["employeePhoneNumber"],
        employeeRole: json["employeeRole"],
        employeeDepartment: json["employeeDepartment"],
        employeePassword: json["employeePassword"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "employeeFirstName": employeeFirstName,
        "employeeMiddleName":
            employeeMiddleName == null ? null : employeeMiddleName,
        "employeeLastName": employeeLastName,
        "employeeNationalId": employeeNationalId,
        "employeeIsAdmin": employeeIsAdmin,
        "employeePhoneNumber": employeePhoneNumber,
        "employeeRole": employeeRole,
        "employeeDepartment": employeeDepartment,
        "employeePassword": employeePassword,
      };
}
