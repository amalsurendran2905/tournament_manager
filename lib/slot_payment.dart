import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SlotPayment extends StatelessWidget {
  const SlotPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PAYMENT',
              style: GoogleFonts.aBeeZee(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
              child: (Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: Container(
                        height: 250,
                        width: 350,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color.fromARGB(255, 2, 183, 165)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 30,
                    child: Row(
                      children: [
                        Transform.rotate(
                            angle: 90 * pi / 180,
                            child: FaIcon(
                              FontAwesomeIcons.simCard,
                              color: Colors.black38,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Transform.rotate(
                            angle: 90 * pi / 180,
                            child: FaIcon(
                              FontAwesomeIcons.wifi,
                              color: Colors.black38,
                            ))
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 40,
                      left: 30,
                      child: Text(
                        '2340  1234  9462',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.black54),
                      )),
                  Positioned(
                      bottom: 85,
                      left: 180,
                      child: Text(
                        '06/25',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      )),
                  Positioned(
                      bottom: 80,
                      left: 30,
                      child: Text(
                        'Amal',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                  Positioned(
                      bottom: 60,
                      right: 40,
                      child: Text(
                        'VISA',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      )),
                  Positioned(
                      top: 80,
                      right: 60,
                      child: GradientText(
                        'FI',
                        style: GoogleFonts.libreBaskerville(
                            fontWeight: FontWeight.bold, fontSize: 30),
                        colors: [Colors.black, Colors.white, Colors.black],
                      )),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                          color: Color.fromARGB(255, 120, 118, 118),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Payment Method',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/pngwing.com.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/phonepe.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/paytmm.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
