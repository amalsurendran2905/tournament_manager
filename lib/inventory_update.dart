import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/adminInventory_view.dart';
import 'package:tournament_app/constants/colors.dart';

class InventoryUpdate extends StatefulWidget {
  final String item;

  final String rdate;

  final String status;

  final String id;

  InventoryUpdate(
      {super.key,
      required this.id,
      required this.item,
      required this.rdate,
      required this.status});

  @override
  State<InventoryUpdate> createState() => _InventoryUpdateState();
}

class _InventoryUpdateState extends State<InventoryUpdate> {
  late TextEditingController _itemController;
  late TextEditingController _rdateController;
  late TextEditingController _statusController;

  @override
  void initState() {
    super.initState();

    _itemController = TextEditingController(text: widget.item);
    _rdateController = TextEditingController(text: widget.rdate);
    _statusController = TextEditingController(text: widget.status);

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
    String url = "http://$ip/tournament/inventory_update.php";

    print(url);

    var response = await http.post(Uri.parse(url), body: {
      "id": widget.id,
      "item": _itemController.text.trim(),
      "return_date": _rdateController.text.trim(),
      "status": _statusController.text.trim(),
    });
    var jsonData = jsonDecode(response.body);
    print("resssss..." + response.body);
    var jsonString = jsonData['message'];

    if (jsonString == 'success') {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Updation success')));

      Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
        return AdmininventoryView();
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
                    'Update the inventory details',
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
                        hintText: 'Item name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: _itemController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Return date',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: _rdateController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Status',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: _statusController,
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
