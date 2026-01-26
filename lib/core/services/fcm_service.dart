import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viral_bites/feature/home/screen/notifications_screen.dart';

class FcmService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // create an instance of firebase messaging

  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notifications
  Future<void> initNotifications() async {
    // request permission from user
    await _firebaseMessaging.requestPermission(provisional: true);

    // fetch the fcm token from the device
    final fcmToken = await _firebaseMessaging.getToken();

    print('Token: $fcmToken');

    initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // else navigate to the notification screen when the notif is recieved and user taps on it.
    Get.to(() => NotificationsScreen(), arguments: message);
  }

  void initPushNotifications() async {
    //handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // attach event listener for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
