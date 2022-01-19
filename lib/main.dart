import 'package:fcm_app/screens/home_screen.dart';
import 'package:fcm_app/screens/message_screen.dart';
import 'package:fcm_app/services/push_notifications_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initilizeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    PushNotificationService.messagesStream.listen((message) { 

      print('My app $message');

      // To show data with SnackBar
      final snackBar = SnackBar(content: Text(message));
      scaffoldKey.currentState?.showSnackBar(snackBar);

      // To redirect screen and sending arguments
      navigatorKey.currentState?.pushNamed('messages', arguments: message);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NOTIFICACIONES',
      initialRoute: 'home',
      navigatorKey: navigatorKey, // To navigate when user clicks the notification
      scaffoldMessengerKey: scaffoldKey, // To show data ins Snackbarwhen user clicks the notification
      routes: {
        'home': (BuildContext context) => HomeScreen(),
        'messages': (BuildContext context) => MessageScreen(),
      },
    );
  }
}
