import 'package:medware/utils/models/notification/notification.dart';

Future<List<Notification>> getNotifications() async {
  const data = [
    {
      '_id': 0,
      'type': 0,
      'title': 'ยินดีต้อนรับสู่ Medware!',
      'body': 'หากพบเจอปัญหาโปรดรายงานมาที่ 63010183@kmitl.ac.th',
      'appointment_id': 0,
      'date': '2022-12-16T08:00:00',
    },
    {
      '_id': 1,
      'type': 1,
      'title': 'มีการเลื่อนนัดหมายของคุณ',
      'body': 'โปรดตรวจสอบรายละเอียด',
      'appointment_id': 1,
      'date': '2022-12-16T08:00:00',
    },
    {
      '_id': 2,
      'type': 2,
      'title': 'มีการยกเลิกนัดหมายของคุณ',
      'body':
          'การตรวจสุขภาพในวันที่ 16 พ.ย. 2565 เวลา 9.00 น. - 11.00 น. ถูกยกเลิกแล้ว',
      'appointment_id': 1,
      'date': '2022-12-16T08:00:00',
    },
  ];

  return data.map<Notification>(Notification.fromJson).toList();
}
