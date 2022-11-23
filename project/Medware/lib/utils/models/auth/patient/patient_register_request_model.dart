class PatientRegisterRequestModel {
  PatientRegisterRequestModel(
      {required this.patientFirstName,
      required this.patientMiddleName,
      required this.patientLastName,
      required this.patientNationalId,
      required this.patientPhoneNumber,
      required this.patientBirthDate,
      required this.patientLocation,
      required this.patientBloodType,
      required this.patientProfileIndex,
      required this.patientPassword});

  late final String patientFirstName;
  late final String patientMiddleName;
  late final String patientLastName;
  late final int patientNationalId;
  late final String patientPhoneNumber;
  late final String patientBirthDate;
  late final String patientLocation;
  late final String patientBloodType;
  late final int patientProfileIndex;
  late final String patientPassword;

  PatientRegisterRequestModel.fromJson(Map<String, dynamic> json) {
    patientFirstName = json['patientFirstName'];
    patientMiddleName = json['patientMiddleName'];
    patientLastName = json['patientLastName'];
    patientNationalId = int.parse(json['patientNationalId']);
    patientPhoneNumber = json['patientPhoneNumber'];
    patientBirthDate = json['patientBirthDate'];
    patientLocation = json['patientLocation'];
    patientBloodType = json['patientBloodType'];
    patientProfileIndex = json['patientProfileIndex'];
    patientPassword = json['patientPassword'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['patientFirstName'] = patientFirstName;
    _data['patientMiddleName'] = patientMiddleName;
    _data['patientLastName'] = patientLastName;
    _data['patientNationalId'] = patientNationalId;
    _data['patientPhoneNumber'] = patientPhoneNumber;
    _data['patientBirthDate'] = patientBirthDate;
    _data['patientLocation'] = patientLocation;
    _data['patientBloodType'] = patientBloodType;
    _data['patientProfileIndex'] = patientProfileIndex;
    _data['patientPassword'] = patientPassword;
    return _data;
  }
}
