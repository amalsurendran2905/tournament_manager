import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/user_gameView.dart';

class UserGameadding extends StatefulWidget {
   UserGameadding({super.key,});

  
  @override
  State<UserGameadding> createState() => _UserGameaddingState();
}

class _UserGameaddingState extends State<UserGameadding> {
  final _gamekey = GlobalKey<FormState>();

  TextEditingController _playersController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _categoryController = TextEditingController();

  SharedPreferences? sharedPreferences;

  late String ip;
  late String id ;


  @override
  void initState() {
    super.initState();

    loadPreference();
  }

  Future<void> loadPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      ip = sharedPreferences?.getString('ip') ?? 'no ip Address';
      id=sharedPreferences?.getString('id')??'no id';

      print('rrrrrrrr'+id);
    });
  }

  void Gameadding(BuildContext ctx) async {
    String url = "http://$ip/tournament/user_gameadding.php?user_id='$id'";

    var response = await http.post(Uri.parse(url), body: {
      "Players_no": _playersController.text.trim(),
      "Category": _categoryController.text.trim(),
      "Contact_no": _phoneController.text.trim(),
      "user_id":id
      
    });
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];

    if (jsonString == 'success') {

      print(id);


      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Successfully added')));
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
        return UsergameView();
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
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: bgc,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Form(
              key: _gamekey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add your Games',
                    style: GoogleFonts.aclonica(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _playersController,
                    decoration: InputDecoration(
                      labelText: 'Number of players',
                      hintText: 'Enter the number of players',
                      prefixIcon: Icon(Icons.people, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter the no.of players';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _categoryController,
                    decoration: InputDecoration(
                      labelText: 'Game category',
                      hintText: 'Enter your Game category',
                      prefixIcon: Icon(Icons.games, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your game category';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Contact number',
                      hintText: 'Enter your contact number',
                      prefixIcon: Icon(Icons.phone, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Contact no';
                      }
                      if (!value.startsWith('+91')) {
                        return 'Contact number must start with +91';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_gamekey.currentState!.validate()) {
                        Gameadding(context);
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      backgroundColor: Colors.black, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
