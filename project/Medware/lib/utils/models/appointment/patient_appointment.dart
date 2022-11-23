class PatientAppointment {
  final int id;
  final int type;
  final DateTime date;
  final DateTime startTime;
  final DateTime finishTime;
  final String doctor;
  final int department;
  final int scheduleId;

  const PatientAppointment({
    required this.id,
    required this.type,
    required this.date,
    required this.startTime,
    required this.finishTime,
    required this.doctor,
    required this.department,
    required this.scheduleId,
  });

  static PatientAppointment fromJson(json) => PatientAppointment(
        id: json['EmployeeId'],
        type: json['Scheduletype'],
        date: DateTime.parse(json['appointmentDate']),
        startTime: DateTime.parse(json['appointmentTimeStart']),
        finishTime: DateTime.parse(json['appointmentTimeEnd']),
        doctor:
            '${json['EmployeeFirstName']} ${json['EmployeeMiddleName']} ${json['EmployeeLastName']}',
        department: json['EmployeeDepartment'],
        scheduleId: json['scheduleId'],
      );
}
