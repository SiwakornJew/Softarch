class Employee {
  final int id;
  final String nationalId;
  final String fName;
  final String mName;
  final String lName;
  final String phoneNumber;
  final int role;
  final int department;

  const Employee({
    required this.id,
    required this.nationalId,
    required this.fName,
    required this.mName,
    required this.lName,
    required this.phoneNumber,
    required this.role,
    required this.department,
  });

  static Employee fromJson(Map<String, dynamic> json) => Employee(
        id: json['employeeId'],
        nationalId: json['employeeNationalId'],
        fName:
            json['employeeFirstName'] != null ? json['employeeFirstName'] : '',
        mName: json['employeeMiddleName'] != null
            ? json['employeeMiddleName']
            : '',
        lName: json['employeeLastName'] != null ? json['employeeLastName'] : '',
        phoneNumber: json['employeePhoneNumber'],
        role: json['employeeRole'],
        department: json['employeeDepartment'],
      );
}
