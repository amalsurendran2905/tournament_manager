import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tournament_app/admin_user.dart';
import 'package:tournament_app/constants/colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return AdminUser();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: bgc,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: const Center(
                child: Image(
              image: AssetImage(
                'assets/sports1.png',
              ),
              fit: BoxFit.fill,
              height: 300,
              width: 300,
            ))));
  }
}
