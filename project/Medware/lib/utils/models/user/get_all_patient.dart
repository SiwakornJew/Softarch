// To parse this JSON data, do
//
//     final allPatient = allPatientFromJson(jsonString);

import 'dart:convert';

List<AllPatient> allPatientFromJson(String str) => List<AllPatient>.from(json.decode(str).map((x) => AllPatient.fromJson(x)));

String allPatientToJson(List<AllPatient> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllPatient {
    AllPatient({
        required this.patientHnId,
        required this.patientFirstName,
        required this.patientMiddleName,
        required this.patientLastName,
        required this.patientNationalId,
        required this.patientPhoneNumber,
        required this.patientBirthDate,
        required this.patientLocation,
        required this.patientBloodType,
        required this.patientProfileIndex,
        required this.patientMedicine,
        required this.patientAllergy,
        required this.patientDisease,
        required this.patientPassword,
    });

    int patientHnId;
    String patientFirstName;
    String patientMiddleName;
    String patientLastName;
    String patientNationalId;
    String patientPhoneNumber;
    DateTime patientBirthDate;
    String patientLocation;
    int patientBloodType;
    int patientProfileIndex;
    dynamic patientMedicine;
    dynamic patientAllergy;
    dynamic patientDisease;
    String patientPassword;

    factory AllPatient.fromJson(Map<String, dynamic> json) => AllPatient(
        patientHnId: json["patientHNId"],
        patientFirstName: json["patientFirstName"],
        patientMiddleName: json["patientMiddleName"],
        patientLastName: json["patientLastName"],
        patientNationalId: json["patientNationalId"],
        patientPhoneNumber: json["patientPhoneNumber"],
        patientBirthDate: DateTime.parse(json["patientBirthDate"]),
        patientLocation: json["patientLocation"],
        patientBloodType: json["patientBloodType"],
        patientProfileIndex: json["patientProfileIndex"],
        patientMedicine: json["patientMedicine"],
        patientAllergy: json["patientAllergy"],
        patientDisease: json["patientDisease"],
        patientPassword: json["patientPassword"],
    );

    Map<String, dynamic> toJson() => {
        "patientHNId": patientHnId,
        "patientFirstName": patientFirstName,
        "patientMiddleName": patientMiddleName,
        "patientLastName": patientLastName,
        "patientNationalId": patientNationalId,
        "patientPhoneNumber": patientPhoneNumber,
        "patientBirthDate": "${patientBirthDate.year.toString().padLeft(4, '0')}-${patientBirthDate.month.toString().padLeft(2, '0')}-${patientBirthDate.day.toString().padLeft(2, '0')}",
        "patientLocation": patientLocation,
        "patientBloodType": patientBloodType,
        "patientProfileIndex": patientProfileIndex,
        "patientMedicine": patientMedicine,
        "patientAllergy": patientAllergy,
        "patientDisease": patientDisease,
        "patientPassword": patientPassword,
    };
}
