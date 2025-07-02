import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/admin_homepage.dart';
import 'package:tournament_app/constants/colors.dart';

class AdminSlotadding extends StatefulWidget {
  AdminSlotadding({super.key});

  @override
  State<AdminSlotadding> createState() => _AdminSlotaddingState();
}

class _AdminSlotaddingState extends State<AdminSlotadding> {
  TextEditingController _timeController = TextEditingController();

  TextEditingController _groundController = TextEditingController();

  TextEditingController _approveController = TextEditingController();

  TextEditingController _cancelController = TextEditingController();

  SharedPreferences? sharedPreferences;

  late String ip;

  @override
  void initState() {
    super.initState();

    loadPreference();
  }

  Future<void> loadPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      ip = sharedPreferences?.getString('ip') ?? 'no ip Address';
    });
  }

  void matches(BuildContext ctx) async {
    String url = "http://$ip/tournament/match_add.php";

    var response = await http.post(Uri.parse(url), body: {
      "Time": _timeController.text.trim(),
      "Ground": _groundController.text.trim(),
      "Approve": _approveController.text.trim(),
      "Cancel": _cancelController.text.trim()
    });
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];

    if (jsonString == 'success') {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Successfully added')));
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
        return AdminInventory();
      }));
    } else {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Adding failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: bgc,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text(
                'BOOKING SLOTS',
                style: GoogleFonts.aBeeZee(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Slot time',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: _timeController),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Ground',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: _groundController),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Approve booking requests',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: _approveController),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Cancel bookings',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: _cancelController),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    matches(context);
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
