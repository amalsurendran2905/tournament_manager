import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/admin_homepage.dart';
import 'package:tournament_app/constants/colors.dart';

class AddInventory extends StatefulWidget {
  const AddInventory({super.key});

  @override
  State<AddInventory> createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  @override
  final addkey = GlobalKey<FormState>();

  TextEditingController _itemController = TextEditingController();

  TextEditingController _rDateController = TextEditingController();

  TextEditingController _priceController = TextEditingController();

  TextEditingController _statusController = TextEditingController();

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
  late String id;

  @override
  void initState() {
    super.initState();

    loadPreference();
  }

  Future<void> loadPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      ip = sharedPreferences?.getString('ip') ?? 'no ip Address';
      id= sharedPreferences?.getString('id')??'no id';
    });
  }

  void inventory(BuildContext ctx) async {
    String url = "http://$ip/tournament/inventory_add.php?user_id='$id'";

    if (_imgUpload != null) {
      String base64Image = base64Encode(_imgUpload!.readAsBytesSync());

      var response = await http.post(Uri.parse(url), body: {
        "item": _itemController.text.trim(),
        "return_date": _rDateController.text.trim(),
        "price": _priceController.text.trim(),
        "status": _statusController.text.trim(),
        "user_id":id,
        "image": base64Image,

      });
      var jsonData = jsonDecode(response.body);
      var jsonString = jsonData['message'];

      if (jsonString == 'success') {
        ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(content: Text('Details added successfully')));
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
          return AdminInventory();
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
      body: Form(
          key: addkey,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
              colors: bgc,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Inventory items',
                        style: GoogleFonts.aclonica(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _itemController,
                        decoration: InputDecoration(
                            labelText: 'Item name:',
                            hintText: 'Enter the Item name',
                            prefixIcon: Icon(
                              Icons.inventory,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the item name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _rDateController,
                        decoration: InputDecoration(
                            labelText: 'Return date',
                            hintText: 'Enter the Return date',
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the return date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                            labelText: 'Price',
                            hintText: 'Enter the Price',
                            prefixIcon: Icon(
                              Icons.currency_rupee_sharp,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the price';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                      TextButton(
                          onPressed: () {
                            if (addkey.currentState!.validate()) {
                              return inventory(context);
                            }
                          },
                          child: Text(
                            'Submit',
                            style: GoogleFonts.aclonica(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
