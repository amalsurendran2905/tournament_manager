import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/user_gameView.dart';

class GameUpdate extends StatefulWidget {
  final String Players_no;

  final String Category;

  final String Contact_no;

  final String id;

  GameUpdate(
      {super.key,
      required this.id,
      required this.Players_no,
      required this.Category,
      required this.Contact_no});

  @override
  State<GameUpdate> createState() => _InventoryUpdateState();
}

class _InventoryUpdateState extends State<GameUpdate> {
  late TextEditingController _playersController;
  late TextEditingController _categoryController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();

    _playersController = TextEditingController(text: widget.Players_no);
    _categoryController = TextEditingController(text: widget.Category);
    _phoneController = TextEditingController(text: widget.Contact_no);

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
    String url = "http://$ip/tournament/game_update.php";

    print(url);

    var response = await http.post(Uri.parse(url), body: {
      "Id": widget.id,
      "Players_no": _playersController.text.trim(),
      "Category": _categoryController.text.trim(),
      "Contact_no": _phoneController.text.trim(),
    });
    var jsonData = jsonDecode(response.body);
    print("resssss..." + response.body);
    var jsonString = jsonData['message'];

    if (jsonString == 'success') {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Updation success')));

      Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
        return UsergameView();
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
                    'Update the Game details',
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
                        hintText: 'No.of players',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: _playersController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Game category',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: _categoryController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Contact number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: _phoneController,
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
