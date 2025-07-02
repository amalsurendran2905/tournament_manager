import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/playersAdding.dart';

late String ip;
late String tm_id;

class playersDetails {
  final String id;
  final String name;
  final String phone;
  final String age;
  final String image;

  playersDetails(
      {required this.id,
      required this.name,
      required this.phone,
      required this.age,
      required this.image});

  factory playersDetails.fromJson(Map<String, dynamic> jsonData) {
    return playersDetails(
        id: jsonData['id'],
        name: jsonData['name'],
        phone: jsonData['phone'],
        age: jsonData['age'],
        image: "http://$ip/tournament/players/" + jsonData['image']);
  }
}

class ViewPlayersD extends StatelessWidget {
  final List<playersDetails> playersDetailsList;

  ViewPlayersD({required this.playersDetailsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: playersDetailsList.length,
      itemBuilder: (context, index) {
        return getPlayersDeatails(playersDetailsList[index], context);
      },
    );
  }
}

Widget getPlayersDeatails(
    playersDetails playersDetailsList, BuildContext context) {
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
                    Container(
                        height: 80,
                        width: 80,
                        child: CircleAvatar(
                          
                            child: Image.network(
                          playersDetailsList.image,
                          height: 100,
                          width: 100,
                        ))),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      playersDetailsList.name,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Text('Phone No :'),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          playersDetailsList.phone,
                          style: GoogleFonts.abel(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    )),
                Row(
                  children: [
                    Text('Age :'),
                    SizedBox(
                      width: 15,
                    ),
                    Text(playersDetailsList.age,
                        style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        )),
                  ],
                ),
              ],
            ),
          ),
        )),
  );
}

class UserPlayersView extends StatefulWidget {
  UserPlayersView({super.key, required this.team_id});

  String team_id;

  @override
  State<UserPlayersView> createState() => _ViewpageState();
}

class _ViewpageState extends State<UserPlayersView> {
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

      print("teamsidd......" + widget.team_id);

      tm_id = widget.team_id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(),
      body: FutureBuilder(
          future: getPlayers(),
          builder: (context, response) {
            if (response.hasData) {
              List<playersDetails>? playersDetailsList = response.data;
              return ViewPlayersD(playersDetailsList: playersDetailsList!);
            } else if (response.hasError) {
              return Text('${response.error}');
            }

            return CircularProgressIndicator();
          }),
    );
  }
}

Future<List<playersDetails>> getPlayers() async {
  final url = "http://$ip/tournament/ViewPlayersDetails.php?teams_id=" + tm_id;

  print(url);
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List playersDetailsList = jsonDecode(response.body);
    return playersDetailsList
        .map(
            (playersDetailsList) => playersDetails.fromJson(playersDetailsList))
        .toList();
  } else {
    throw Exception('Something went wrong');
  }
}
