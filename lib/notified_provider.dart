import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_service.dart';

class NotifiedProvider extends ChangeNotifier {
  bool _hasNotifications;
  NotifiedProvider() : _hasNotifications = false;
  
  get hasNotifications => _hasNotifications;

  checkNotifications(NotifyHelper notifyHelper) async {
    notifyHelper.flutterLocalNotificationsPlugin
        .pendingNotificationRequests()
        .then((value) {
      _hasNotifications = value.isEmpty;
      notifyListeners();
    });
  }

  void cancelAllNotifications(NotifyHelper notifyHelper){
    notifyHelper.cancelAllNotifications();
    checkNotifications(notifyHelper);
  }

  void setNotifications(NotifyHelper notifyHelper) {
    //Test notification
    _setSundayAndTuesdayNotification(notifyHelper, 13, 01, 'Test 2');
    // _setSundayAndTuesdayNotification(notifyHelper,3, 47, 'Test 1');
    //Start for Sunday and Tuesday
    _setSundayAndTuesdayNotification(notifyHelper, 15, 00, 'Ice Breaking');
    //Full English
    _setSundayAndTuesdayNotification(notifyHelper, 15, 10, 'Full English ');
    //Break
    _setSundayAndTuesdayNotification(notifyHelper, 16, 25, 'Break ');
    //Full Arabic
    _setSundayAndTuesdayNotification(notifyHelper, 16, 35, 'Full Arabic ');
    //The end of the session
    _setSundayAndTuesdayNotification(
        notifyHelper, 17, 00, 'The end of the session ');
    checkNotifications(notifyHelper);
  }

  void _setSundayAndTuesdayNotification(
    NotifyHelper notifyHelper,
    int hour,
    int minute,
    String title,
  ) {
    //Test notification
    // notifyHelper.scheduleNotification(
    //     hour, minute, '10/2/2023', title, DateTimeComponents.dayOfWeekAndTime);
    //Sunday
    notifyHelper.scheduleNotification(
        hour, minute, '10/1/2023', title, DateTimeComponents.dayOfWeekAndTime);
    //Tuesday
    notifyHelper.scheduleNotification(
        hour, minute, '10/3/2023', title, DateTimeComponents.dayOfWeekAndTime);
  }
}
