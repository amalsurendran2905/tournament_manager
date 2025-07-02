import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tournament_app/admin_homepage.dart';
import 'package:tournament_app/constants/colors.dart';

class Turf_screen extends StatefulWidget {
  Turf_screen({super.key});

  @override
  State<Turf_screen> createState() => _Turf_screenState();
}

class _Turf_screenState extends State<Turf_screen> {
  final _turfKey = GlobalKey<FormState>();

  TextEditingController _tNameController = TextEditingController();

  TextEditingController _locationController = TextEditingController();

  TextEditingController _amountController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _desController = TextEditingController();

  TextEditingController _slotController = TextEditingController();

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

  void turf(BuildContext ctx) async {
    String url = "http://$ip/tournament/turf.php";

    if (_imgUpload != null) {
      String base64Image = base64Encode(_imgUpload!.readAsBytesSync());

      var response = await http.post(Uri.parse(url), body: {
        "Turf": _tNameController.text.trim(),
        "Location": _locationController.text.trim(),
        "Fee": _amountController.text.trim(),
        "Description": _desController.text.trim(),
        "Slot": _slotController.text.trim(),
        "Images": base64Image,
      });
      var jsonData = jsonDecode(response.body);
      var jsonString = jsonData['message'];

      if (jsonString == 'success') {
        ScaffoldMessenger.of(ctx)
            .showSnackBar(SnackBar(content: Text('Successfully submitted')));

        Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
          return AdminInventory();
        }));
      } else {
        ScaffoldMessenger.of(ctx)
            .showSnackBar(SnackBar(content: Text('Submission failed')));
      }
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
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
                key: _turfKey,
                child: Column(
                  children: [
                    Text('Turf Details',
                        style: GoogleFonts.aclonica(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _tNameController,
                      decoration: InputDecoration(
                        labelText: ' Turf Name',
                        hintText: 'Enter Turf Name',
                        prefixIcon: Icon(Icons.house, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Turf Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: ' Turf Location',
                        hintText: 'Enter Turf Location',
                        prefixIcon: Icon(Icons.place, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Turf Location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: ' Turf fee',
                        hintText: 'Enter Turf fee',
                        prefixIcon:
                            Icon(Icons.currency_rupee, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Turf fee';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: ' Contact no',
                        hintText: 'Enter the Contact no',
                        prefixIcon: Icon(Icons.phone, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Contact no';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _desController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter the Description',
                        prefixIcon:
                            Icon(Icons.description, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _slotController,
                      decoration: InputDecoration(
                        labelText: 'Available slots',
                        hintText: 'Enter the slots',
                        prefixIcon: Icon(Icons.timelapse, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the slots';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
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
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_turfKey.currentState!.validate()) {
                            return turf(context);
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20),
                        ))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
