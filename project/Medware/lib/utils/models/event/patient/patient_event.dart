import 'dart:convert';

List<PatientEvent> PatientEventFromJson(String str) => List<PatientEvent>.from(
    json.decode(str).map((x) => PatientEvent.fromJson(x)));

class PatientEvent {
  late final int id;
  late final int capacity;
  late final int patientCount;
  late final int type;
  late final DateTime date;
  late final DateTime startTime;
  late final DateTime finishTime;
  late final String doctorFirstName;
  late final String doctorMiddleName;
  late final String doctorLastName;
  late final int department;

  PatientEvent({
    required this.id,
    required this.capacity,
    required this.patientCount,
    required this.date,
    required this.startTime,
    required this.finishTime,
    required this.type,
    required this.doctorFirstName,
    required this.doctorMiddleName,
    required this.doctorLastName,
    required this.department,
  });

  factory PatientEvent.fromJson(Map<String, dynamic> json) => PatientEvent(
        id: json['scheduleId'],
        capacity: json['scheduleCapacity'],
        patientCount: json['patientCount'],
        type: json['scheduleType'],
        date: DateTime.parse(json['scheduleDate']),
        startTime: DateTime.parse(json['scheduleStartTIme']),
        finishTime: DateTime.parse(json['scheduleFinishTime']),
        doctorFirstName: json['docterFirstName'],
        doctorMiddleName: json['docterMiddleName'],
        doctorLastName: json['docterLastName'],
        department: json['docterDepartMent'],
      );
}
