class EmployeeAppointment {
  final int id;
  final int type;
  final DateTime date;
  final DateTime startTime;
  final DateTime finishTime;
  final int patientCount;

  const EmployeeAppointment({
    required this.id,
    required this.type,
    required this.date,
    required this.startTime,
    required this.finishTime,
    required this.patientCount,
  });

  static EmployeeAppointment fromJson(json) => EmployeeAppointment(
        id: json['scheduleId'],
        type: json['scheduleType'],
        date: json['scheduleDate'] != null
            ? DateTime.parse(json['scheduleDate'])
            : DateTime(0),
        startTime: json['scheduleStartTIme'] != null
            ? DateTime.parse(json['scheduleStartTIme'])
            : DateTime(0),
        finishTime: json['scheduleFinishTime'] != null
            ? DateTime.parse(json['scheduleFinishTime'])
            : DateTime(0),
        patientCount: json['patientCount'],
      );
}
