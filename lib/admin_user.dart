import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tournament_app/admin_login.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/user_login.dart';
import 'package:tournament_app/user_signup.dart';

class AdminUser extends StatefulWidget {
  const AdminUser({super.key});

  @override
  State<AdminUser> createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> {
  String fullText =
      "Welcome to Sports World! Explore, register, and enjoy tournaments.";
  String displayedText = "";
  int index = 0;

  @override
  void initState() {
    super.initState();
    _animateText();
  }

  void _animateText() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (index < fullText.length) {
        setState(() {
          displayedText += fullText[index];
          index++;
        });
        _animateText();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: bgc,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                displayedText,
                style: GoogleFonts.aclonica(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext) {
                        return UserLogin();
                      }));
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            Text(
                              'USER',
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Icon(
                              Icons.person,
                              color: const Color.fromARGB(255, 135, 197, 249),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext) {
                        return AdminLogin();
                      }));
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            Text(
                              'ADMIN',
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Icon(
                              Icons.person,
                              color: const Color.fromARGB(255, 135, 197, 249),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
