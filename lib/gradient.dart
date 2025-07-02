import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class grad extends StatelessWidget {
  const grad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
            decoration: const BoxDecoration(
              
              gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 86, 176, 249),
                Color.fromARGB(255, 123, 193, 250),
                Color.fromARGB(255, 168, 212, 248),
                Color.fromARGB(255, 201, 230, 252),
                Color.fromARGB(255, 168, 212, 248),
               Color.fromARGB(255, 123, 193, 250),
                Color.fromARGB(255, 86, 176, 249),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),)
    );
  }
}