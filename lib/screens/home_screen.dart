import 'package:flutter/material.dart';
import 'package:push_notification/services/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notification = NotificationServices();
  @override
  void initState() {
    notification.initializeLocalNotifications(context);
    notification.getNotificationPermission();
    notification.getDeviceToken();
    notification.getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Home Screen", style: TextStyle(fontSize: 35))),
    );
  }
}
