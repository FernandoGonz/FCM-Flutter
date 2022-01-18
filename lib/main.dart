import 'package:fcm_app/screens/home_screen.dart';
import 'package:fcm_app/screens/message_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NOTIFICACIONES',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(),
        'messages': (BuildContext context) => MessageScreen(),
      },
    );
  }
}
