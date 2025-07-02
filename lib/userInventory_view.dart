import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/inventory_purchaseForm.dart';

late String ip;
String uid='';

class inventoryDetails {
  final String id;
  final String item;
  final String rdate;
  final String price;
  final String status;
  final String image;

  inventoryDetails(
      {required this.id,
      required this.item,
      required this.rdate,
      required this.price,
      required this.status,
      required this.image});

  factory inventoryDetails.fromJson(Map<String, dynamic> jsonData) {
    return inventoryDetails(
        id: jsonData['id'],
        item: jsonData['item'],
        rdate: jsonData['return_date'],
        price: jsonData['price'],
        
        status: jsonData['status'],
        image: "http://$ip/tournament/images/" + jsonData['image']);
  }
}

class ViewInventoryD extends StatelessWidget {
  final List<inventoryDetails> inventoryDetailsList;

  ViewInventoryD({required this.inventoryDetailsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: inventoryDetailsList.length,
      itemBuilder: (context, index) {
        return getInventoryDeatails(inventoryDetailsList[index], context);
      },
    );
  }
}

Widget getInventoryDeatails(
    inventoryDetails inventoryDetailsList, BuildContext context) {
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
                  inventoryDetailsList.item,
                  style: GoogleFonts.abel(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Image.network(
                  inventoryDetailsList.image,
                  height: 150,
                  width: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      inventoryDetailsList.rdate,
                      style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                    Text(
                      inventoryDetailsList.status,
                      style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.currency_rupee,
                      color: Colors.black,
                    ),
                    Text(
                      inventoryDetailsList.price,
                      style: GoogleFonts.abel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                if (inventoryDetailsList.status != 'unavailable')
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext) {
                          return InventoryPurchaseform(
                            fee: inventoryDetailsList.price,
                            Inv_id: inventoryDetailsList.id, id: '$uid',
                          );
                        }));
                      },
                      child: Text('PURCHASE',
                          style: GoogleFonts.abel(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 1, 170, 6)))),
              ],
            ),
          ),
        )),
  );
}

class UserinventoryView extends StatefulWidget {
  const UserinventoryView({super.key});

  @override
  State<UserinventoryView> createState() => _ViewpageState();
}

class _ViewpageState extends State<UserinventoryView> {
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
      uid = sharedPreferences?.getString('id') ??'no id';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(),
      body: FutureBuilder(
          future: getInventories(),
          builder: (context, response) {
            if (response.hasData) {
              List<inventoryDetails>? inventoryDetailsList = response.data;
              return ViewInventoryD(
                  inventoryDetailsList: inventoryDetailsList!);
            } else if (response.hasError) {
              return Text('${response.error}');
            }

            return CircularProgressIndicator();
          }),
    );
  }
}

Future<List<inventoryDetails>> getInventories() async {
  final url = "http://$ip/tournament/ViewInventoryDetails.php?id=$uid";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List inventoryDetailsList = jsonDecode(response.body);
    return inventoryDetailsList
        .map((inventoryDetailsList) =>
            inventoryDetails.fromJson(inventoryDetailsList))
        .toList();
  } else {
    throw Exception('Something went wrong');
  }
}
