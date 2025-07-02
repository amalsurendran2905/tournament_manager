import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/teamsAdding.dart';

late String ip;

class tournamentDetails {
  final String id;
  final String item;
  final String teams;
  final String duration;

  tournamentDetails({
    required this.id,
    required this.item,
    required this.teams,
    required this.duration,
  });

  factory tournamentDetails.fromJson(Map<String, dynamic> jsonData) {
    return tournamentDetails(
      id: jsonData['id'],
      item: jsonData['item'],
      teams: jsonData['teams'],
      duration: jsonData['duration'],
    );
  }
}

class ViewTournamentD extends StatelessWidget {
  final List<tournamentDetails> tournamentDetailsList;

  ViewTournamentD({required this.tournamentDetailsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tournamentDetailsList.length,
      itemBuilder: (context, index) {
        return getTournamentDeatails(tournamentDetailsList[index], context);
      },
    );
  }
}

Widget getTournamentDeatails(
    tournamentDetails tournamentDetailsList, BuildContext context) {
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
                  tournamentDetailsList.item,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        tournamentDetailsList.teams + ' Teams',
                        style: GoogleFonts.abel(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        tournamentDetailsList.duration,
                        style: GoogleFonts.abel(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    print("iddddddd" + tournamentDetailsList.id);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext) {
                      return Teamsadding(
                        Ti_d: tournamentDetailsList.id,
                      );
                    }));
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Card(
                      color: Color.fromARGB(255, 176, 213, 243),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Add Teams',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                  fontSize: 20),
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.green[600],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
  );
}

class UserTournamentView extends StatefulWidget {
  UserTournamentView({super.key});

  @override
  State<UserTournamentView> createState() => _ViewpageState();
}

class _ViewpageState extends State<UserTournamentView> {
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
          future: getTournaments(),
          builder: (context, response) {
            if (response.hasData) {
              List<tournamentDetails>? tournamentDetailsList = response.data;
              return ViewTournamentD(
                  tournamentDetailsList: tournamentDetailsList!);
            } else if (response.hasError) {
              return Text('${response.error}');
            }

            return CircularProgressIndicator();
          }),
    );
  }
}

Future<List<tournamentDetails>> getTournaments() async {
  final url = "http://$ip/tournament/ViewTournamentDetails.php";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List tournamentDetailsList = jsonDecode(response.body);
    return tournamentDetailsList
        .map((tournamentDetailsList) =>
            tournamentDetails.fromJson(tournamentDetailsList))
        .toList();
  } else {
    throw Exception('Something went wrong');
  }
}
