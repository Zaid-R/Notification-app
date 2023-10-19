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
      print('List length : ${list.length}');
      notifyListeners();
      print("_hasNotifications : $_hasNotifications");
    });
  }

  void _setHasNotifications(bool value){
      _hasNotifications = value;
      notifyListeners();
  }

  int cancelations = 0;
  int pendings = 0;
  void cancelAllNotifications() {
    cancelations++;
    print('Cancelations : $cancelations');
    _notificationHelper.cancelAllNotifications();
    _setHasNotifications(false);
  }

  void setNotifications() {
    pendings++;
    //Test notification
    _setSundayAndTuesdayNotification(11, 36, 'Test 2');
    // _setSundayAndTuesdayNotification(notifyHelper,3, 47, 'Test 1');
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
    print('Pendings : $pendings');
    _setHasNotifications(true);
  }

  Future<void> _setSundayAndTuesdayNotification(
    int hour,
    int minute,
    String title,
  ) async {
    //Test notification
    _notificationHelper.scheduleNotification(
        hour, minute, '10/12/2023', title, DateTimeComponents.dayOfWeekAndTime);
    //Sunday
    // notifyHelper.scheduleNotification(
    //     hour, minute, '10/1/2023', title, DateTimeComponents.dayOfWeekAndTime);
    // //Tuesday
    // notifyHelper.scheduleNotification(
    //     hour, minute, '10/3/2023', title, DateTimeComponents.dayOfWeekAndTime);
  }
}
