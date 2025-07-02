import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tournament_app/add_inventory.dart';
import 'package:tournament_app/adminInventory_view.dart';
import 'package:tournament_app/admin_slotAdding.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/turf.dart';

class AdminInventory extends StatelessWidget {
  const AdminInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: bgc,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext) {
                          return AdmininventoryView();
                        }));
                      },
                      child: Container(
                        height: 170,
                        width: 150,
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
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'INVENTORY',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Icon(
                                Icons.store,
                                color: Colors.black,
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
                          return Turf_screen();
                        }));
                      },
                      child: Container(
                        height: 170,
                        width: 150,
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
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'TURFS',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Icon(
                                Icons.store,
                                color: Colors.black,
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
                          return AddInventory();
                        }));
                      },
                      child: Container(
                        height: 170,
                        width: 150,
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
                                'Add items',
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
                          return AdminSlotadding();
                        }));
                      },
                      child: Container(
                        height: 170,
                        width: 150,
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
                                'Add Slots',
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
