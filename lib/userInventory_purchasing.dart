import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/user_inventoryPayment.dart';

class UserinventoryPurchasing extends StatefulWidget {
  final price;

  var item;

  UserinventoryPurchasing({super.key, required this.price, required this.item,required this.id});

  String id;

  @override
  State<UserinventoryPurchasing> createState() => _UserinventoryPurchasingState();
}

class _UserinventoryPurchasingState extends State<UserinventoryPurchasing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: bgc,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Payment',
                style: GoogleFonts.aBeeZee(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 50,
              ),
              Card(
                shadowColor: Colors.black,
                surfaceTintColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    children: [
                      Text(widget.item,
                          style: GoogleFonts.aBeeZee(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext) {
                            return UserInventorypayment();
                          }));
                        },
                        child: Card(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.currency_rupee,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      widget.price + '(per day)',
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Pay Now',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
