import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/turfDetails.dart';
import 'package:tournament_app/userTurfdetails.dart';

late String ip;

class turfDetails {
  final String id;
  final String name;
  final String image;
  final String location;
  final String amount;
  final String description;
  final String slot;

  turfDetails(
      {required this.id,
      required this.name,
      required this.image,
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
        slot: jsonData['slot'],
        image: "http://$ip/tournament/turf/" + jsonData['image']);
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
                  Text(
                    turfDetailsList.name,
                    style: GoogleFonts.abel(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext) {
                          return Turfdetails(
                              name: turfDetailsList.name,
                              location: turfDetailsList.location,
                              description: turfDetailsList.description,
                              amount: turfDetailsList.amount,
                              slot: turfDetailsList.slot);
                        }));
                      },
                      child: Image.network(
                        turfDetailsList.image,
                        height: 150,
                        width: 150,
                      )),
                ],
              ),
            )),
      ));
}

class UserturfView extends StatefulWidget {
  const UserturfView({super.key});

  @override
  State<UserturfView> createState() => _ViewpageState();
}

class _ViewpageState extends State<UserturfView> {
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
