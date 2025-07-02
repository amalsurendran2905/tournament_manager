import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/userInventory_view.dart';

class InventoryPurchaseform extends StatefulWidget {
  InventoryPurchaseform({super.key, required this.fee, required this.Inv_id,required this.id});
  String fee;
  String Inv_id;
  String id;

  @override
  State<InventoryPurchaseform> createState() => _InventoryPurchaseformState();
}

final _key = GlobalKey<FormState>();

TextEditingController _cnameController = TextEditingController();
TextEditingController _cnumberController = TextEditingController();

class _InventoryPurchaseformState extends State<InventoryPurchaseform> {
  List<String> cards = <String>[
    'Credit',
    'Debit',
    'ATM',
  ];

  String Selected_card = 'Credit';

  String? Vaild_till;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        Vaild_till = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  SharedPreferences? sharedPreferences;

  late String ip;
  late String uid;

  @override
  void initState() {
    super.initState();

    loadPreference();
  }

  Future<void> loadPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      ip = sharedPreferences?.getString('ip') ?? 'no ip Address';
      uid = sharedPreferences?.getString('id') ?? 'no id';
    });
  }

  void submit(BuildContext ctx) async {
    String url = "http://$ip/tournament/inventory_payment.php?user_id='$uid'";

    var response = await http.post(Uri.parse(url), body: {
      "inv_id": widget.Inv_id,
      "fee": widget.fee,
      "user_id":uid
    });
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];

    if (jsonString == 'success') {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Registration success')));
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
        return UserinventoryView();
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
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
            colors: bgc,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Total Amount :',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          Icon(Icons.currency_rupee),
                          Text(
                            widget.fee,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Card Type :',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      DropdownButton(
                          value: Selected_card,
                          items: cards.map(
                            (String options) {
                              return DropdownMenuItem(
                                child: Text(
                                  options,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                value: options,
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              Selected_card = value!;
                            });
                          }),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enter Card Name :',
                        helperText: 'Enter Card Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter the card name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enter Card Number :',
                        helperText: 'Enter Card Number'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter the card number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Valid Till :',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Vaild_till != null
                                ? "Validity $Vaild_till"
                                : "Validity",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month),
                        const Text('MM/YY'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          return submit(context);
                        }
                      },
                      child: Text(
                        'Make Payment',
                        style: GoogleFonts.aBeeZee(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
