import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:push_notification/app/app_routers.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeLocalNotifications(BuildContext context) async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        String? payload = response.payload;
        print("asrfjal;dfj :-------------$payload");
        if (payload == screens.recommendation.name) {
          context.goNamed(screens.recommendation.name);
        }
      },
    );
  }

  Future<void> getNotificationPermission() async {
    NotificationSettings permissionStatus = await messaging.requestPermission();
    if (permissionStatus.authorizationStatus ==
        AuthorizationStatus.authorized) {
      print("----Authorized");
    }

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions();
  }

  Future<void> getDeviceToken() async {
    String? token = await messaging.getToken();
    print(token);
  }

  Future<void> getNotifications() async {
    await FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification!.title);
      print(message.notification!.body);
      print(message.data["type"]);
      showNotifications(message);
    });
  }

  showNotifications(RemoteMessage message) {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          "1",
          "channelName",
          importance: Importance.max,
          priority: Priority.high,
        );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
      payload: message.data["type"],
    );
  }
}
