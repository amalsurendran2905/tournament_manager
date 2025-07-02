import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/bottomNB.dart';
import 'package:tournament_app/constants/colors.dart';

class UserUpdate extends StatefulWidget {
  final String name;

  final String phone_no;

  final String username;

  final String id;

  UserUpdate(
      {super.key,
      required this.id,
      required this.name,
      required this.phone_no,
      required this.username});

  @override
  State<UserUpdate> createState() => _InventoryUpdateState();
}

class _InventoryUpdateState extends State<UserUpdate> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _unameController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.name);
    _phoneController = TextEditingController(text: widget.phone_no);
    _unameController = TextEditingController(text: widget.username);

    loadPreference();
  }

  SharedPreferences? sharedPreferences;

  late String ip;

  Future<void> loadPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      ip = sharedPreferences?.getString('ip') ?? 'no ip Address';
    });
  }

  void updateDetails(BuildContext ctx) async {
    String url = "http://$ip/tournament/userDetails_update.php";

    print(url);

    var response = await http.post(Uri.parse(url), body: {
      "id": widget.id,
      "name": _nameController.text.trim(),
      "phone_no": _phoneController.text.trim(),
      "username": _unameController.text.trim(),
    });
    var jsonData = jsonDecode(response.body);
    print("resssss..." + response.body);
    var jsonString = jsonData['message'];

    if (jsonString == 'success') {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Updation success')));

      Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
        return Bmnr(
          name: '',
          male: '',
        );
      }));
    } else {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Updation failed')));
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
              child: Column(
                children: [
                  Text(
                    'Update your details',
                    style: GoogleFonts.abhayaLibre(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: _nameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Phone number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: _phoneController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Username',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: _unameController,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextButton(
                      onPressed: () {
                        updateDetails(context);
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 30),
                      ))
                ],
              ),
            )));
  }
}
