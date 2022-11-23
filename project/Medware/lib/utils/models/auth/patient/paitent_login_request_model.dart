class PatientLoginRequestModel {
  PatientLoginRequestModel({
    required this.nationalCardId,
    required this.password,
  });
  late final String nationalCardId;
  late final String password;

  PatientLoginRequestModel.fromJson(Map<String, dynamic> json) {
    nationalCardId = json['nationalCardId'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nationalCardId'] = nationalCardId;
    _data['password'] = password;
    return _data;
  }
}
