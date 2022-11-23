// To parse this JSON data, do
//
//     final confirmAddPatient = confirmAddPatientFromJson(jsonString);

import 'dart:convert';

ConfirmAddPatient confirmAddPatientFromJson(String str) => ConfirmAddPatient.fromJson(json.decode(str));

String confirmAddPatientToJson(ConfirmAddPatient data) => json.encode(data.toJson());

class ConfirmAddPatient {
    ConfirmAddPatient({
        required this.scheduleId,
        required this.patientNationalId,
    });

    String scheduleId;
    String patientNationalId;

    factory ConfirmAddPatient.fromJson(Map<String, dynamic> json) => ConfirmAddPatient(
        scheduleId: json["scheduleId"],
        patientNationalId: json["patientNationalId"],
    );

    Map<String, dynamic> toJson() => {
        "scheduleId": scheduleId,
        "patientNationalId": patientNationalId,
    };
}
