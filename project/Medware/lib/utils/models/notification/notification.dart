class Notification {
  final int id;
  final int type;
  final String title;
  final String body;
  final int appointmentId;
  final DateTime dateCreated;

  const Notification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.appointmentId,
    required this.dateCreated,
  });

  static Notification fromJson(Map<String, dynamic> json) => Notification(
        id: json['id'],
        type: json['type'],
        title: json['title'],
        body: json['body'],
        appointmentId: json['appointment_id'],
        dateCreated: DateTime.parse(json['date']),
      );
}
