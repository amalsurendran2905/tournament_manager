import 'package:flutter/material.dart';
import 'package:tournament_app/purchased_inventory.dart';
import 'package:tournament_app/userInventory_view.dart';

class InventoryHome extends StatelessWidget {
  const InventoryHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext) {
                      return UserinventoryView();
                    }));
                  },
                  child: Container(
                    height: 170,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 1, 140, 255),
                            Color.fromARGB(255, 51, 156, 241),
                            Color.fromARGB(255, 118, 193, 254),
                            Color.fromARGB(255, 118, 193, 254),
                            Color.fromARGB(255, 118, 193, 254),
                            Color.fromARGB(255, 47, 156, 245),
                            Color.fromARGB(255, 1, 138, 250),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )),
                    child: const Center(
                        child: Text(
                      'Items',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30),
                    )),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext) {
                      return PurchasedInventory();
                    }));
                  },
                  child: Container(
                    height: 170,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 1, 140, 255),
                            Color.fromARGB(255, 51, 156, 241),
                            Color.fromARGB(255, 118, 193, 254),
                            Color.fromARGB(255, 118, 193, 254),
                            Color.fromARGB(255, 118, 193, 254),
                            Color.fromARGB(255, 47, 156, 245),
                            Color.fromARGB(255, 1, 138, 250),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )),
                    child: const Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Purchased',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 30),
                        ),
                        Text(
                          'items',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 30),
                        ),
                      ],
                    )),
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
