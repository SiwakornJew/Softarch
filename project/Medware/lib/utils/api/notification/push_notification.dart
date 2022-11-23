import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class PushNotification {
  static final _noti = FlutterLocalNotificationsPlugin();
  static final onClickNotifications = BehaviorSubject<String?>();

  static Future init() async {
    final androidInitSetting =
        AndroidInitializationSettings('@drawable/event_available');

    final iOSInitSetting = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestSoundPermission: false,
      requestBadgePermission: false,
    );

    final initSetting = InitializationSettings(
      android: androidInitSetting,
      iOS: iOSInitSetting,
    );

    await _noti.initialize(
      initSetting,
      onDidReceiveNotificationResponse: (res) async =>
          onClickNotifications.add(res.payload),
      // onDidReceiveBackgroundNotificationResponse: (res) async =>
      //     onClickNotifications.add(res.payload),
    );
  }

  static Future showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async =>
      _noti.show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'main',
            'channel name',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: payload,
      );

  static Future log({
    required int id,
    required int type,
    required String title,
    required String body,
    required int appointmentId,
    required DateTime dateCreated,
  }) async =>
      {};
}
