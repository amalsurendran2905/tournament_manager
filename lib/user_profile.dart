import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tournament_app/userDetails_update.dart';
import 'package:tournament_app/user_login.dart';

late String ip;
late String id;

class userDetails {
  final String id;
  final String name;
  final String phone_number;
  final String username;
  final String password;

  userDetails({
    required this.id,
    required this.name,
    required this.phone_number,
    required this.username,
    required this.password,
  });

  factory userDetails.fromJson(Map<String, dynamic> jsonData) {
    return userDetails(
      id: jsonData['id'],
      name: jsonData['name'],
      phone_number: jsonData['phone_no'],
      username: jsonData['username'],
      password: jsonData['password'],
    );
  }
}

class ViewUserD extends StatelessWidget {
  final List<userDetails> userDetailsList;

  ViewUserD({required this.userDetailsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userDetailsList.length,
      itemBuilder: (context, index) {
        return getUserDeatails(userDetailsList[index], context);
      },
    );
  }
}

Widget getUserDeatails(userDetails userDetailsList, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Center(
        child: Container(
          height: 650,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 140, 198, 246)),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Color.fromARGB(255, 41, 38, 38),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        Text(
                          'Name :',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          userDetailsList.name,
                          style: GoogleFonts.abel(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Ph.No :',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      userDetailsList.phone_number,
                      style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Username :',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      userDetailsList.username,
                      style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext) {
                        return UserUpdate(
                          id: userDetailsList.id,
                          name: userDetailsList.name,
                          phone_no: userDetailsList.phone_number,
                          username: userDetailsList.username,
                        );
                      }));
                    },
                    child: Text(
                      'UPDATE',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 20),
                    )),SizedBox(height: 40,),
                     Align(alignment: Alignment.bottomRight,
                       child: TextButton(onPressed: (){
                                       showDialog(barrierDismissible:false,
                                       context: context, builder:(BuildContext context){
                                         return AlertDialog(
                                           backgroundColor:  Color.fromARGB(255, 248, 224, 232),
                                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                           title: const Row(
                        children: [
                          
                          Icon(Icons.logout,color: Colors.black),SizedBox(width: 10,),
                          Text('Log out',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                        ],
                                           ),
                                           content: Text('you want to log out now ?',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),),
                       actions: [
                                TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return UserLogin();
                                  }));
                                }, child: Text('Yes',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),)),
                                SizedBox(width: 100,),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text('N0',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)))
                              ],
                                         );
                                       } 
                                       );
                                     }, child: const Text('Log out',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),)),
                     ),
              ],
            ),
          ),
        ),
      ));
}

class UserProfile extends StatefulWidget {
  UserProfile({super.key});

  @override
  State<UserProfile> createState() => _ViewpageState();

  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _usernameController;
}

class _ViewpageState extends State<UserProfile> {
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
      id = sharedPreferences?.getString('id') ?? 'no id';

      print(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
     
      body: FutureBuilder(
          future: getUsers(),
          builder: (context, response) {
            if (response.hasData) {
              List<userDetails>? userDetailsList = response.data;
              return ViewUserD(userDetailsList: userDetailsList!);
            } else if (response.hasError) {
              return Text('${response.error}');
            }

            return CircularProgressIndicator();
          }),
    );
  }
}

Future<List<userDetails>> getUsers() async {
  final url = "http://$ip/tournament/ViewUserDetails.php?id=$id";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List userDetailsList = jsonDecode(response.body);
    return userDetailsList
        .map((userDetailsList) => userDetails.fromJson(userDetailsList))
        .toList();
  } else {
    throw Exception('Something went wrong');
  }
}
