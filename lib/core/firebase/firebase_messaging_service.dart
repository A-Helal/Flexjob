import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  factory FirebaseMessagingService() => _instance;

  FirebaseMessagingService._internal();
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize Firebase Messaging
  Future<void> init() async {
    // Request permission for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // IMPORTANT: Set foreground notification presentation options for iOS
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Configure local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: DarwinInitializationSettings(
              requestAlertPermission: true,
              requestBadgePermission: true,
              requestSoundPermission: true,
            ));

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: _notificationTapBackground,
    );

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleMessage(message);
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Get the initial message if the app is opened from a terminated state
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    getFCMtoken();

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      await subscribeToTopic('all');
    } else {}
  }

  getFCMtoken() async {
    await _firebaseMessaging.getToken();
  }

  // Handle incoming messages
  void _handleMessage(RemoteMessage message) async {
    // Note: We don't need to manually show notification here because
    // setForegroundNotificationPresentationOptions already handles it for iOS
    // and Android shows notifications automatically
  }

  // Display a local notification
  Future<void> _showNotification(RemoteNotification notification) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription:
          'This channel is used for important notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: 'default',
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    try {
      await _localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          platformChannelSpecifics,
          payload: 'item x');
    } catch (e) {
      // ignore — notification display failure is non-fatal
    }
  }

  // Background message handler
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    _instance._handleMessage(message);
  }

  // Subscribe to a topic (optional)
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  // Unsubscribe from a topic (optional)
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  Future<void> subscribeToUserTopic(int userId) async {
    await _firebaseMessaging.subscribeToTopic('user_$userId');
  }

  Future<void> unsubscribeFromUserTopic(int userId) async {
    await _firebaseMessaging.unsubscribeFromTopic('user_$userId');
  }

  // Check if notifications are authorized
  Future<bool> areNotificationsAuthorized() async {
    NotificationSettings settings =
        await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  // Handle notification tap when the app is in the background
  @pragma('vm:entry-point')
  static Future<void> _notificationTapBackground(
      NotificationResponse details) async {
    final String? token = await LocalData.getToken();
    if (token != null && token.isNotEmpty) {
      CustomMainRouter.push(NotificationsRoute());
    }
  }

  // Handle notification tap when the app is in the foreground
  Future<void> _onReceiveNotification(NotificationResponse details) async {
    final String? token = await LocalData.getToken();
    if (token != null && token.isNotEmpty) {
      CustomMainRouter.push(NotificationsRoute());
    }
  }
}
