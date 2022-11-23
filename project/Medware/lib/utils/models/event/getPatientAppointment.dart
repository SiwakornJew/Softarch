
import 'dart:convert';

List<GetPatientAppointment> getPatientAppointmentFromJson(String str) =>
    List<GetPatientAppointment>.from(
        json.decode(str).map((x) => GetPatientAppointment.fromJson(x)));

String getPatientAppointmentToJson(List<GetPatientAppointment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPatientAppointment {
  GetPatientAppointment({
    required this.appointmentTimeStart,
    required this.patientFirstName,
    required this.patientMiddleName,
    required this.appointmentDate,
    required this.appointmentTimeEnd,
    required this.patientLastName,
  });

  DateTime appointmentTimeStart;
  String patientFirstName;
  String patientMiddleName;
  DateTime appointmentDate;
  DateTime appointmentTimeEnd;
  String patientLastName;

  factory GetPatientAppointment.fromJson(Map<String, dynamic> json) =>
      GetPatientAppointment(
        appointmentTimeStart: DateTime.parse(json["appointmentTimeStart"]),
        patientFirstName: json["patientFirstName"],
        patientMiddleName: json["patientMiddleName"],
        appointmentDate: DateTime.parse(json["appointmentDate"]),
        appointmentTimeEnd: DateTime.parse(json["appointmentTimeEnd"]),
        patientLastName: json["patientLastName"],
      );

  Map<String, dynamic> toJson() => {
        "appointmentTimeStart": appointmentTimeStart.toIso8601String(),
        "patientFirstName": patientFirstName,
        "patientMiddleName": patientMiddleName,
        "appointmentDate":
            "${appointmentDate.year.toString().padLeft(4, '0')}-${appointmentDate.month.toString().padLeft(2, '0')}-${appointmentDate.day.toString().padLeft(2, '0')}",
        "appointmentTimeEnd": appointmentTimeEnd.toIso8601String(),
        "patientLastName": patientLastName,
      };
}