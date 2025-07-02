import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/tournament.dart';

class Usertournamentadd extends StatefulWidget {
  const Usertournamentadd({super.key});

  @override
  State<Usertournamentadd> createState() => _UsertournamentaddState();
}

class _UsertournamentaddState extends State<Usertournamentadd> {
  final _sportskey = GlobalKey<FormState>();

  TextEditingController _itemController = TextEditingController();

  TextEditingController _teamController = TextEditingController();

  TextEditingController _durationController = TextEditingController();

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

  void sports(BuildContext ctx) async {
    String url = "http://$ip/tournament/user_tournamentAdd.php";

    var response = await http.post(Uri.parse(url), body: {
      "item": _itemController.text.trim(),
      "teams": _teamController.text.trim(),
      "duration": _durationController.text.trim(),
    });
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];

    if (jsonString == 'success') {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Registration success')));
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
        return TOURNAMENT();
      }));
    } else {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Registration failed')));
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
          child: Form(
            key: _sportskey,
            child: Column(
              children: [
                Text(
                  'ADD TOURNAMENTS',
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
                      hintText: 'Sports Item',
                      prefixIcon: Icon(
                        Icons.sports_cricket_outlined,
                        color: Colors.black45,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: _itemController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your Name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'No.Of Teams',
                      prefixIcon: Icon(
                        Icons.people_alt,
                        color: Colors.black45,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: _teamController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your Name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Duration',
                      prefixIcon: Icon(
                        Icons.timelapse_outlined,
                        color: Colors.black45,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: _durationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your Name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_sportskey.currentState!.validate()) {
                        sports(context);
                      }
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
      ),
    );
  }
}
