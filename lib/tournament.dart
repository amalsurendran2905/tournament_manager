import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tournament_app/tournament_items.dart';
import 'package:tournament_app/userTournamentAdd.dart';
import 'package:tournament_app/user_tournamentView.dart';

class TOURNAMENT extends StatelessWidget {
  TOURNAMENT({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext) {
                  return UserTournamentItem();
                }));
              },
              child: Container(
                height: 150,
                width: double.infinity,
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
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.sports_football,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'TOURNAMENT',
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
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext) {
                      return Usertournamentadd();
                    }));
                  },
                  child: Container(
                    height: 150,
                    width: 170,
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
                          const Icon(
                            Icons.sports_cricket_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                'ADD',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                'TOURNAMENT',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext) {
                      return UserTournamentView();
                    }));
                  },
                  child: Container(
                    height: 150,
                    width: 170,
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
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'YOUR',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            'TOURNAMENTS',
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
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
