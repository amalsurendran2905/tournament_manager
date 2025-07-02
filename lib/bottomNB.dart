import 'package:flutter/material.dart';
import 'package:tournament_app/user_homepage.dart';
import 'package:tournament_app/tournament.dart';
import 'package:tournament_app/user_profile.dart';

class Bmnr extends StatefulWidget {
  const Bmnr({
    super.key,
    required String name,
    required String male,
  });

  @override
  State<Bmnr> createState() => _BmnrState();
}

class _BmnrState extends State<Bmnr> {
  int abc = 0;

  final List<Widget> _pages = [UserHomepage(), TOURNAMENT(), UserProfile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[abc],
      bottomNavigationBar: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[300],
        currentIndex: abc,
        onTap: (value) {
          setState(() {
            abc = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_football), label: 'Tournament'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
