import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/tournament.dart';

class PlayersAdding extends StatefulWidget {
  PlayersAdding({super.key, required this.Tms_id});

  String Tms_id;

  @override
  State<PlayersAdding> createState() => _UserSignupState();
}

class _UserSignupState extends State<PlayersAdding> {
  final _signkey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _ageController = TextEditingController();

  File? _imgUpload;
  final select = ImagePicker();
  Future<void> _selectImage() async {
    try {
      final _selectedFile = await select.pickImage(source: ImageSource.gallery);

      if (_selectedFile != null) {
        setState(() {
          _imgUpload = File(_selectedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No image')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to pick image')));
    }
  }

  SharedPreferences? sharedPreferences;

  late String ip;

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

  void submit(BuildContext ctx) async {
    String url = "http://$ip/tournament/players_adding.php";

    if (_imgUpload != null) {
      String base64Image = base64Encode(_imgUpload!.readAsBytesSync());

      var response = await http.post(Uri.parse(url), body: {
        "name": _nameController.text.trim(),
        "phone": _phoneController.text.trim(),
        "age": _ageController.text.trim(),
        "teams_id": widget.Tms_id,
        "image": base64Image
      });
      var jsonData = jsonDecode(response.body);
      var jsonString = jsonData['message'];

      if (jsonString == 'success') {
        ScaffoldMessenger.of(ctx)
            .showSnackBar(SnackBar(content: Text('Details added successfully')));
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
          return TOURNAMENT();
        }));
      } else {
        ScaffoldMessenger.of(ctx)
            .showSnackBar(SnackBar(content: Text('Details adding failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: bgc,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Form(
              key: _signkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Players',
                    style: GoogleFonts.aclonica(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter Name',
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone No',
                      hintText: 'Enter Phone No',
                      prefixIcon: Icon(Icons.phone, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Contact no';
                      }
                      if (!value.startsWith('+91')) {
                        return 'Contact number must start with +91';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      hintText: 'Enter age',
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your age';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color.fromARGB(255, 118, 193, 254),
                        ),
                        height: 120,
                        width: 120,
                        child: _imgUpload != null
                            ? Image.file(
                                _imgUpload!,
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Image',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20),
                                  ),
                                  Icon(Icons.add),
                                ],
                              )),
                    onTap: () {
                      _selectImage();
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_signkey.currentState!.validate()) {
                        submit(context);
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      backgroundColor: Colors.black, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
