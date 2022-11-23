import 'dart:convert';

List<Allschedules> allschedulesFromJson(String str) => List<Allschedules>.from(
    json.decode(str).map((x) => Allschedules.fromJson(x)));

String allschedulesToJson(List<Allschedules> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Allschedules {
  Allschedules({
    required this.scheduleCapacity,
    required this.docterFirstName,
    required this.scheduleType,
    required this.docterMiddleName,
    required this.scheduleFinishTime,
    required this.scheduleDate,
    required this.patientCount,
    required this.docterDepartMent,
    required this.docterLastName,
    required this.doctorEmployeeId,
    required this.scheduleId,
    required this.scheduleStartTIme,
  });

  int scheduleCapacity;
  String docterFirstName;
  int scheduleType;
  dynamic docterMiddleName;
  DateTime scheduleFinishTime;
  DateTime scheduleDate;
  int patientCount;
  int docterDepartMent;
  String docterLastName;
  int doctorEmployeeId;
  int scheduleId;
  DateTime scheduleStartTIme;

  factory Allschedules.fromJson(Map<String, dynamic> json) => Allschedules(
        scheduleCapacity: json["scheduleCapacity"],
        docterFirstName: json["docterFirstName"],
        scheduleType: json["scheduleType"],
        docterMiddleName: json["docterMiddleName"],
        scheduleFinishTime: DateTime.parse(json["scheduleFinishTime"]),
        scheduleDate: DateTime.parse(json["scheduleDate"]),
        patientCount: json["patientCount"],
        docterDepartMent: json["docterDepartMent"],
        docterLastName: json["docterLastName"],
        scheduleId: json["scheduleId"],
        doctorEmployeeId: json["doctorEmployeeId"],
        scheduleStartTIme: DateTime.parse(json["scheduleStartTIme"]),
      );

  Map<String, dynamic> toJson() => {
        "scheduleCapacity": scheduleCapacity,
        "docterFirstName": docterFirstName,
        "scheduleType": scheduleType,
        "docterMiddleName": docterMiddleName,
        "scheduleFinishTime": scheduleFinishTime.toIso8601String(),
        "scheduleDate":
            "${scheduleDate.year.toString().padLeft(4, '0')}-${scheduleDate.month.toString().padLeft(2, '0')}-${scheduleDate.day.toString().padLeft(2, '0')}",
        "patientCount": patientCount,
        "docterDepartMent": docterDepartMent,
        "docterLastName": docterLastName,
        "scheduleId": scheduleId,
        "doctorEmployeeId": doctorEmployeeId,
        "scheduleStartTIme": scheduleStartTIme.toIso8601String(),
      };
}
