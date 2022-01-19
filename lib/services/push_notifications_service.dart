// 61:09:0C:3C:4B:72:7E:DE:C7:EC:B8:F6:FB:B1:72:09:F7:AE:11:5E

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = StreamController.broadcast();

  static Stream<String> get messagesStream => _messageStream.stream;

  static Future<void> initilizeApp() async {
    // push notifications
    // To initialize Firebase app
    await Firebase.initializeApp();
    // Getting token
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessagedHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // local Notifications
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    // When the device gets a notification in Background
    print('Background Handler ${message.messageId}');
    _messageStream.add(message.notification?.title ?? 'No title');
    // for message description
    // _messageStream.add(message.notification?.body ?? 'No title');
  }

  static Future<void> _onMessagedHandler(RemoteMessage message) async {
    // When the device gets a notification in Foreground
    print('On Message Handler ${message.messageId}');
    // Object Arguments key-value with message.data
    // print(message.data);
    _messageStream.add(message.data['product'] ?? 'No product');
  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async {
    // When the user taps the notification
    print('On Message OpenApp Handler ${message.messageId}');
    _messageStream.add(message.data['product'] ?? 'No product');
  }

  static closeStreams() {
    _messageStream.close();
  }

}