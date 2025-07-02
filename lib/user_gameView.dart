import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/game_update.dart';

late String ip;
late String uid;

class gameDetails {
  final String id;
  final String players_no;
  final String category;
  final String phone_no;

  gameDetails({
    required this.id,
    required this.players_no,
    required this.category,
    required this.phone_no,
  });

  factory gameDetails.fromJson(Map<String, dynamic> jsonData) {
    return gameDetails(
      id: jsonData['Id'],
      players_no: jsonData['Players_no'],
      category: jsonData['Category'],
      phone_no: jsonData['Contact_no'],
      
    );
  }
}

class ViewGameD extends StatelessWidget {
  final List<gameDetails> gameDetailsList;

  ViewGameD({required this.gameDetailsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gameDetailsList.length,
      itemBuilder: (context, index) {
        return getGameDetails(gameDetailsList[index], context);
      },
    );
  }
}

Widget getGameDetails(gameDetails gameDetailsList, BuildContext context) {
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
                Row(
                  children: [
                    Text(
                      'No.of players :',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontSize: 18),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      gameDetailsList.players_no,
                      style: GoogleFonts.abel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Category :',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontSize: 18),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      gameDetailsList.category,
                      style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Phone No :',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontSize: 18),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      gameDetailsList.phone_no,
                      style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (BuildContext) {
                              return GameUpdate(
                                  id: gameDetailsList.id,
                                  Players_no: gameDetailsList.players_no,
                                  Category: gameDetailsList.category,
                                  Contact_no: gameDetailsList.phone_no);
                            }));
                          },
                          child: const Text(
                            'UPDATE',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 20),
                          )),
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              delete(context, gameDetailsList.id);
                            },
                            child: const Text(
                              'DELETE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 20),
                            )))
                  ],
                )
              ],
            ),
          ),
        )),
  );
}

void delete(BuildContext context, String id) async {
  String url = "http://$ip/tournament/game_delete.php";

  var response = await http.post(Uri.parse(url), body: {
    "Id": id,
  });
  var jsonData = jsonDecode(response.body);
  var jsonString = jsonData['message'];

  if (jsonString == 'success') {


    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Deleting success')));

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
      return UsergameView();
    }));
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Deleting failed')));
  }
}

class UsergameView extends StatefulWidget {
   UsergameView({super.key,});




  @override
  State<UsergameView> createState() => _ViewpageState();
}

class _ViewpageState extends State<UsergameView> {
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
      uid = sharedPreferences?.getString('id') ?? 'no id';
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(),
      body: FutureBuilder(
          future: getGames(),
          builder: (context, response) {
            if (response.hasData) {
              List<gameDetails>? gameDetailsList = response.data;
              return ViewGameD(gameDetailsList: gameDetailsList!);
            } else if (response.hasError) {
              return Text('${response.error}');
            }

            return CircularProgressIndicator();
          }),
    );
  }
}

Future<List<gameDetails>> getGames() async {
  final url = "http://$ip/tournament/ViewGameDetails.php?user_id=$uid";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List gameDetailsList = jsonDecode(response.body);
    return gameDetailsList
        .map((gameDetailsList) => gameDetails.fromJson(gameDetailsList))
        .toList();
  } else {
    throw Exception('Something went wrong');
  }
}
