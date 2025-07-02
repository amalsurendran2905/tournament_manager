import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/playersAdding.dart';
import 'package:tournament_app/players_View.dart';

late String ip;
late String tId;

class teamsDetails {
  final String id;
  final String name;
  final String place;
  final String image;

  teamsDetails(
      {required this.id,
      required this.name,
      required this.place,
      required this.image});

  factory teamsDetails.fromJson(Map<String, dynamic> jsonData) {
    return teamsDetails(
        id: jsonData['id'],
        name: jsonData['name'],
        place: jsonData['place'],
        image: "http://$ip/tournament/photos/" + jsonData['image']);
  }
}

class ViewTeamsD extends StatelessWidget {
  final List<teamsDetails> teamsDetailsList;

  ViewTeamsD({required this.teamsDetailsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teamsDetailsList.length,
      itemBuilder: (context, index) {
        return getTeamsDeatails(teamsDetailsList[index], context);
      },
    );
  }
}

Widget getTeamsDeatails(teamsDetails teamsDetailsList, BuildContext context) {
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
                          teamsDetailsList.image,
                          height: 150,
                          width: 150,
                        ))),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      teamsDetailsList.name,
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
                    alignment: Alignment.centerLeft,
                    child: Text(
                      teamsDetailsList.place,
                      style: GoogleFonts.abel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    )),
                Row(
                  children: [
                     Expanded(
                       child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext){
                            return PlayersAdding(Tms_id: teamsDetailsList.id);
                          }));
                        },
                         child: Card(
                          color: Color.fromARGB(255, 176, 213, 243),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  'Add Players',
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
                     ),
                    
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext) {
                            return UserPlayersView(team_id: teamsDetailsList.id);
                          }));
                        },
                        child: Card(
                          color: Color.fromARGB(255, 176, 213, 243),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  'View Players',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                      fontSize: 20),
                                ),
                                Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.green[600],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
  );
}

class UserTeamsView extends StatefulWidget {
  UserTeamsView({super.key, required this.t_id});

  String t_id;

  @override
  State<UserTeamsView> createState() => _ViewpageState();
}

class _ViewpageState extends State<UserTeamsView> {
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

      print("tournamentId......" + widget.t_id);

      tId = widget.t_id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(),
      body: FutureBuilder(
          future: getTeams(),
          builder: (context, response) {
            if (response.hasData) {
              List<teamsDetails>? teamsDetailsList = response.data;
              return ViewTeamsD(teamsDetailsList: teamsDetailsList!);
            } else if (response.hasError) {
              return Text('${response.error}');
            }

            return CircularProgressIndicator();
          }),
    );
  }
}

Future<List<teamsDetails>> getTeams() async {
  final url = "http://$ip/tournament/ViewTeamsDetails.php?tournament_id=" + tId;

  print(url);
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List teamsDetailsList = jsonDecode(response.body);
    return teamsDetailsList
        .map((teamsDetailsList) => teamsDetails.fromJson(teamsDetailsList))
        .toList();
  } else {
    throw Exception('Something went wrong');
  }
}
