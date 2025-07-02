import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/constants/colors.dart';

late String ip;

class turfDetails {
  final String id;
  final String name;

  final String location;
  final String amount;
  final String description;
  final String slot;

  turfDetails(
      {required this.id,
      required this.name,
      required this.location,
      required this.amount,
      required this.description,
      required this.slot});

  factory turfDetails.fromJson(Map<String, dynamic> jsonData) {
    return turfDetails(
        id: jsonData['id'],
        name: jsonData['name'],
        location: jsonData['location'],
        amount: jsonData['amount'],
        description: jsonData['description'],
        slot: jsonData['slot']);
  }
}

class ViewTurfD extends StatelessWidget {
  final List<turfDetails> turfDetailsList;

  ViewTurfD({required this.turfDetailsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: turfDetailsList.length,
      itemBuilder: (context, index) {
        return getTurfDetails(turfDetailsList[index], context);
      },
    );
  }
}

Widget getTurfDetails(turfDetails turfDetailsList, BuildContext context) {
  return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: bgc,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      color: Colors.white,
                      child: Text(
                        turfDetailsList.name,
                        style: GoogleFonts.abel(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),
                  Text(
                    turfDetailsList.location,
                    style: GoogleFonts.abel(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    turfDetailsList.description,
                    style: GoogleFonts.abel(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.currency_rupee,
                            color: Colors.green,
                          ),
                          Text(
                            turfDetailsList.amount,
                            style: GoogleFonts.abel(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Available Slots',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.green,
                        fontSize: 20),
                  ),
                  Text(
                    turfDetailsList.slot,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 17),
                  )
                ],
              ),
            )),
      ));
}

class UserturfDetails extends StatefulWidget {
  const UserturfDetails({super.key});

  @override
  State<UserturfDetails> createState() => _ViewpageState();
}

class _ViewpageState extends State<UserturfDetails> {
  SharedPreferences? sharedPreferences;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(),
      body: FutureBuilder(
          future: getTurfs(),
          builder: (context, response) {
            if (response.hasData) {
              List<turfDetails>? turfDetailsList = response.data;
              return ViewTurfD(turfDetailsList: turfDetailsList!);
            } else if (response.hasError) {
              return Text('${response.error}');
            }

            return CircularProgressIndicator();
          }),
    );
  }
}

Future<List<turfDetails>> getTurfs() async {
  final url = "http://$ip/tournament/turfView.php";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List turfDetailsList = jsonDecode(response.body);
    return turfDetailsList
        .map((turfDetailsList) => turfDetails.fromJson(turfDetailsList))
        .toList();
  } else {
    throw Exception('Something went wrong');
  }
}
