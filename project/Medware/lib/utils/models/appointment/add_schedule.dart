// To parse this JSON data, do
//
//     final createSchedule = createScheduleFromJson(jsonString);

import 'dart:convert';

CreateSchedule createScheduleFromJson(String str) => CreateSchedule.fromJson(json.decode(str));

String createScheduleToJson(CreateSchedule data) => json.encode(data.toJson());

class CreateSchedule {
    CreateSchedule({
        required this.scheduleCapacity,
        required this.scheduleStart,
        required this.scheduleEnd,
        required this.scheduleDate,
        required this.scheduleLocation,
        required this.employeeId,
        required this.scheduleType,
    });

    String scheduleCapacity;
    DateTime scheduleStart;
    DateTime scheduleEnd;
    DateTime scheduleDate;
    String scheduleLocation;
    String employeeId;
    String scheduleType;

    factory CreateSchedule.fromJson(Map<String, dynamic> json) => CreateSchedule(
        scheduleCapacity: json["scheduleCapacity"],
        scheduleStart: DateTime.parse(json["scheduleStart"]),
        scheduleEnd: DateTime.parse(json["scheduleEnd"]),
        scheduleDate: DateTime.parse(json["scheduleDate"]),
        scheduleLocation: json["scheduleLocation"],
        employeeId: json["employeeId"],
        scheduleType: json["scheduleType"],
    );

    Map<String, dynamic> toJson() => {
        "scheduleCapacity": scheduleCapacity,
        "scheduleStart": scheduleStart.toIso8601String(),
        "scheduleEnd": scheduleEnd.toIso8601String(),
        "scheduleDate": "${scheduleDate.year.toString().padLeft(4, '0')}-${scheduleDate.month.toString().padLeft(2, '0')}-${scheduleDate.day.toString().padLeft(2, '0')}",
        "scheduleLocation": scheduleLocation,
        "employeeId": employeeId,
        "scheduleType": scheduleType,
    };
}
