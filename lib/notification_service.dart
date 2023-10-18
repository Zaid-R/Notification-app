import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotifyHelper {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int _id = 1;

  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      _flutterLocalNotificationsPlugin;

  final _notificationDetails = const NotificationDetails(
      android:
          AndroidNotificationDetails('your channel id', 'custom sound channel',
              channelDescription: 'your channel description',
              importance: Importance.max,
              priority: Priority.max,
              playSound: true,
              //Custom sound
              sound: RawResourceAndroidNotificationSound('bell_sound')));

  Future<void> scheduleNotification(int hour, int minute, String date,
      String title, DateTimeComponents period) async {
    tz.initializeTimeZones();
    //assignment for _local field in tz
    //without this line you'll get error because _local isn't initialized
    tz.setLocalLocation(
        tz.getLocation(await FlutterTimezone.getLocalTimezone()));

    //print('location: ${await FlutterTimezone.getLocalTimezone()}');

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      _id++,
      title,
      '',
      _nextInstanceOfTenAM(hour, minute, date),
      _notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      //DateTimeComponents.time for daily notification at the time you determined
      matchDateTimeComponents: period,
    );
  }

  Future<void> displayNotification() async {
    await _flutterLocalNotificationsPlugin.show(
        _id, 'title', 'body', _notificationDetails);
  }

  tz.TZDateTime _nextInstanceOfTenAM(int hour, int minutes, String date) {
    //final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    var formattedDate = DateFormat.yMd().parse(date);
    final tz.TZDateTime fd = tz.TZDateTime.from(formattedDate, tz.local);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, fd.year, fd.month, fd.day, hour, minutes);

    return scheduledDate;
  }

  void cancelAllNotifications() {
    _flutterLocalNotificationsPlugin.cancelAll();
  }

  initializeNotification() async {
    // this is for latest iOS settings
    //a
    // ignore: constant_identifier_names
    const DarwinInitializationSettings IOSInitializationSettings =
        DarwinInitializationSettings(); //for IOS
    //b
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/launcher_icon"); //for Android

    //c (a,b)
    InitializationSettings initializationSettings =
        const InitializationSettings(
      iOS: IOSInitializationSettings,
      android: androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }
}
