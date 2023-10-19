import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_service.dart';

class NotifiedProvider extends ChangeNotifier {
  bool _hasNotifications;
  final NotifyHelper _notificationHelper;
  NotifiedProvider()
      : _notificationHelper = NotifyHelper(),
        _hasNotifications = false {
    _notificationHelper.initializeNotification();
    _checkNotifications();
  }

  bool get hasNotifications => _hasNotifications;

  void _checkNotifications() {
    _notificationHelper.flutterLocalNotificationsPlugin
        .pendingNotificationRequests()
        .then((list) {
      _hasNotifications = list.isNotEmpty;
      notifyListeners();
    });
  }

  void _setHasNotifications(bool value){
      _hasNotifications = value;
      notifyListeners();
  }

  void cancelAllNotifications() {
    _notificationHelper.cancelAllNotifications();
    _setHasNotifications(false);
  }

  void setNotifications() {
    //Start for Sunday and Tuesday
    _setSundayAndTuesdayNotification(15, 00, 'Ice Breaking');
    //Full English
    _setSundayAndTuesdayNotification(15, 10, 'Full English ');
    //Break
    _setSundayAndTuesdayNotification(16, 25, 'Break ');
    //Full Arabic
    _setSundayAndTuesdayNotification(16, 35, 'Full Arabic ');
    //The end of the session
    _setSundayAndTuesdayNotification(17, 00, 'The end of the session ');
    _setHasNotifications(true);
  }

  Future<void> _setSundayAndTuesdayNotification(
    int hour,
    int minute,
    String title,
  ) async {
    //Sunday
    _notificationHelper.scheduleNotification(
        hour, minute, '10/1/2023', title, DateTimeComponents.dayOfWeekAndTime);
    //Tuesday
    _notificationHelper.scheduleNotification(
        hour, minute, '10/3/2023', title, DateTimeComponents.dayOfWeekAndTime);
  }
}
