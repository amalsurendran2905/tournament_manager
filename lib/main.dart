import 'package:flutter/material.dart';
import 'package:tournament_app/gradient.dart';
import 'package:tournament_app/ip.dart';
import 'package:tournament_app/userSlot_booking.dart';
import 'package:tournament_app/user_signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.white)),
     
      home:  Ip_page(),
    // home: UserSignup(),
    );
  }
}
