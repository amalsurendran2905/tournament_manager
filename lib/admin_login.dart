import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/admin_homepage.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:http/http.dart' as http;

class AdminLogin extends StatefulWidget {
  AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final ad_key = GlobalKey<FormState>();

  TextEditingController _unameController = TextEditingController();

  TextEditingController _passController = TextEditingController();

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

  Future adLog(BuildContext ctx) async {
    String url = "http://$ip/tournament/admin_login.php";

    var data = {
      "Username": _unameController.text.trim(),
      "Password": _passController.text.trim()
    };
    var response = await http.post(Uri.parse(url), body: data);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      var jsonString = jsonData['message'];

      print(jsonString);

      if (jsonString == 'success') {
        ScaffoldMessenger.of(ctx)
            .showSnackBar(SnackBar(content: Text('Login success')));
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
          return AdminInventory();
        }));
      } else {
        ScaffoldMessenger.of(ctx)
            .showSnackBar(SnackBar(content: Text('something went wrong')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: bgc,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
              key: ad_key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: GoogleFonts.aclonica(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _unameController,
                    decoration: InputDecoration(
                        labelText: 'Enter your username',
                        hintText: 'Please enter your username',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(style: BorderStyle.solid))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                        labelText: 'Enter your password',
                        hintText: 'Please enter your password',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(style: BorderStyle.solid))),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pleade enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (ad_key.currentState!.validate()) {
                          adLog(context);
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
              )),
        ),
      ),
    );
  }
}
