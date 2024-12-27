import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FlutterLocalNotifications(),
    );
  }
}

class FlutterLocalNotifications extends StatefulWidget {
  const FlutterLocalNotifications({super.key});

  @override
  State<FlutterLocalNotifications> createState() => _FlutterLocalNotificationsState();
}

class _FlutterLocalNotificationsState extends State<FlutterLocalNotifications> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  // إعداد الإشعارات
  void _initializeNotifications() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // إظهار الإشعار
  void _showNotification() async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
      );

      const notificationDetails = NotificationDetails(android: androidDetails);

      // إرسال الإشعار
      await flutterLocalNotificationsPlugin.show(
        0,
        'New Notification',
        'This is a local notification.',
        notificationDetails,
      );

      // إذا تم إرسال الإشعار بنجاح
      print('Notification Sent Successfully!');

      // عرض Snackbar لتأكيد إرسال الإشعار
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notification Sent Successfully!')),
      );
    } catch (e) {
      // إذا حدث خطأ أثناء إرسال الإشعار
      print('Error: $e');

      // عرض Snackbar في حالة حدوث خطأ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to Send Notification!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Notifications')),
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.notifications),
          iconSize: 50.0,
          onPressed: _showNotification, // عند الضغط على الأيقونة، سيتم إرسال الإشعار
          tooltip: 'Send Notification', // النص الذي يظهر عند التمرير فوق الأيقونة
        ),
      ),
    );
  }
}
