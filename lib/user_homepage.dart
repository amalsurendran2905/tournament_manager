import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tournament_app/inventor_home.dart';
import 'package:tournament_app/userGameAdding.dart';
import 'package:tournament_app/userInventory_view.dart';
import 'package:tournament_app/userTurf_view.dart';
import 'package:tournament_app/user_gameView.dart';

class UserHomepage extends StatefulWidget {
  UserHomepage({
    super.key,
  });

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext) {
                          return InventoryHome();
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 1, 140, 255),
                                Color.fromARGB(255, 51, 156, 241),
                                Color.fromARGB(255, 118, 193, 254),
                                Color.fromARGB(255, 118, 193, 254),
                                Color.fromARGB(255, 118, 193, 254),
                                Color.fromARGB(255, 47, 156, 245),
                                Color.fromARGB(255, 1, 138, 250),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/inventories.png',
                                height: 120,
                                width: 120,
                              ),
                              Text(
                                'Inventory',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext) {
                          return UserturfView();
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 1, 140, 255),
                                Color.fromARGB(255, 51, 156, 241),
                                Color.fromARGB(255, 118, 193, 254),
                                Color.fromARGB(255, 118, 193, 254),
                                Color.fromARGB(255, 118, 193, 254),
                                Color.fromARGB(255, 47, 156, 245),
                                Color.fromARGB(255, 1, 138, 250),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/slot.png',
                                height: 120,
                                width: 120,
                              ),
                              Text(
                                'Turfs',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext) {
                          return UserGameadding();
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 1, 140, 255),
                                Color.fromARGB(255, 51, 156, 241),
                                Color.fromARGB(255, 118, 193, 254),
                                Color.fromARGB(255, 118, 193, 254),
                                Color.fromARGB(255, 118, 193, 254),
                                Color.fromARGB(255, 47, 156, 245),
                                Color.fromARGB(255, 1, 138, 250),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/games.png',
                                height: 120,
                                width: 120,
                              ),
                              Text(
                                'Add game',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext) {
                          return UsergameView();
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 1, 140, 255),
                                Color.fromARGB(255, 51, 156, 241),
                                Color.fromARGB(255, 118, 193, 254),
                                Color.fromARGB(255, 118, 193, 254),
                                Color.fromARGB(255, 118, 193, 254),
                                Color.fromARGB(255, 47, 156, 245),
                                Color.fromARGB(255, 1, 138, 250),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/gameee.png',
                                height: 120,
                                width: 120,
                              ),
                              Text(
                                'Your games',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
