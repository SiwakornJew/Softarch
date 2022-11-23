class EmployeeRegisterRequestModel {
  EmployeeRegisterRequestModel({
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
  late final String employeeFirstName;
  late final String employeeMiddleName;
  late final String employeeLastName;
  late final String employeeNationalId;
  late final bool employeeIsAdmin;
  late final String employeePhoneNumber;
  late final int employeeRole;
  late final int employeeDepartment;
  late final String employeePassword;

  EmployeeRegisterRequestModel.fromJson(Map<String, dynamic> json) {
    employeeFirstName = json['employeeFirstName'];
    employeeMiddleName = json['employeeMiddleName'];
    employeeLastName = json['employeeLastName'];
    employeeNationalId = json['employeeNationalId'];
    employeeIsAdmin = json['employeeIsAdmin'];
    employeePhoneNumber = json['employeePhoneNumber'];
    employeeRole = json['employeeRole'];
    employeeDepartment = json['employeeDepartment'];
    employeePassword = json['employeePassword'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['employeeFirstName'] = employeeFirstName;
    _data['employeeMiddleName'] = employeeMiddleName;
    _data['employeeLastName'] = employeeLastName;
    _data['employeeNationalId'] = employeeNationalId;
    _data['employeeIsAdmin'] = employeeIsAdmin;
    _data['employeePhoneNumber'] = employeePhoneNumber;
    _data['employeeRole'] = employeeRole;
    _data['employeeDepartment'] = employeeDepartment;
    _data['employeePassword'] = employeePassword;
    return _data;
  }
}
