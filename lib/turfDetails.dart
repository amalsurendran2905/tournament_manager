import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/userSlot_booking.dart';

class Turfdetails extends StatelessWidget {
  final name;
  final location;
  final description;
  final amount;
  final slot;
  Turfdetails(
      {super.key,
      required this.name,
      required this.location,
      required this.description,
      required this.amount,
      required this.slot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: 600,
          width: 400,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              colors: bgc,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name,
                    style: GoogleFonts.aBeeZee(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: const Color.fromARGB(255, 72, 70, 70),
                      ),
                      Text(location,
                          style: GoogleFonts.aBeeZee(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(228, 54, 3, 3))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'About the Turf :',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                    )),
                Text(description,
                    style: GoogleFonts.aBeeZee(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.currency_rupee,
                        color: const Color.fromARGB(255, 2, 124, 6),
                      ),
                      Text(
                        amount,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: const Color.fromARGB(255, 2, 124, 6)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Card(
                  color: Colors.white60,
                  shadowColor: Colors.black,
                  surfaceTintColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          'Available Slots',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.green,
                              fontSize: 25),
                        ),
                        Text(
                          slot,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext) {
                      return UserslotBooking(
                        T_name: name,
                      );
                    }));
                  },
                  child: Card(
                    color: Color.fromARGB(255, 29, 29, 29),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Book Slots',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
