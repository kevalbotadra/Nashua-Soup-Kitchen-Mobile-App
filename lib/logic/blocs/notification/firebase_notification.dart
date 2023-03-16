import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "general_notifications", " General Notifications",
    description: "This channel is used for ALL notification",
    importance: Importance.max);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
  // AwesomeNotifications().createNotificationFromJsonData(message.data);
}

class FirebaseNotifications {
  initialize() async {
    await Firebase.initializeApp();
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM is " + fcmToken.toString());

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var initalizationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);

    var initializationSettings = InitializationSettings(
        android: initalizationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message.data);
      if (Platform.isAndroid) {
        RemoteNotification? notification = message.notification;

        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.max,
                priority: Priority.high,
                groupKey: channel.groupId);

        NotificationDetails notificationDetails =
            NotificationDetails(android: androidNotificationDetails);

        flutterLocalNotificationsPlugin.show(notification.hashCode,
            notification!.title, notification.body, notificationDetails);

        List<ActiveNotification>? activeNotifications =
            await flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.getActiveNotifications();

        if (activeNotifications!.length > 0) {
          List<String> lines =
              activeNotifications.map((e) => e.title.toString()).toList();

          InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
              lines,
              contentTitle: "${activeNotifications.length - 1} messages",
              summaryText: "${activeNotifications.length - 1} messages");
          AndroidNotificationDetails groupNotificationDetails =
              AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  styleInformation: inboxStyleInformation,
                  setAsGroupSummary: true);

          NotificationDetails groupNotificationDetailsPlatformSpefics =
              NotificationDetails(android: groupNotificationDetails);
          await flutterLocalNotificationsPlugin.show(
              0, '', '', groupNotificationDetailsPlatformSpefics);
        }
      } else if (Platform.isIOS) {
        print(message);
        RemoteNotification? notification = message.notification;
        IOSNotificationDetails iOSNotificationDetails = IOSNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

        NotificationDetails notificationDetails =
            NotificationDetails(iOS: iOSNotificationDetails);

        flutterLocalNotificationsPlugin.show(notification.hashCode,
            notification!.title, notification.body, notificationDetails);
      }

      AwesomeNotifications().initialize(null, [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          playSound: true,
        )
      ]);
    });
  }

  Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    return token;
  }

  subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }
}
