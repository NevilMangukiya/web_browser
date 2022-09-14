import 'package:adv_mirror_wall/screens/java.dart';
import 'package:adv_mirror_wall/screens/tutorial.dart';
import 'package:adv_mirror_wall/screens/w3.dart';
import 'package:adv_mirror_wall/screens/wikipedia.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<Widget> _pages = <Widget>[
    WikipediaaScreen(),
    JavaScreen(),
    TutorialScreen(),
    W3Screen(),
  ];
  int selcetIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: _pages.elementAt(selcetIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selcetIndex,
        onTap: (val) {
          setState(() {
            selcetIndex = val;
          });
        },
        selectedItemColor: Colors.green,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/wiki.png",
              scale: 15,
            ),
            label: "Wifipedia",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/java.png",
              scale: 9,
            ),
            label: "JavatPoint",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/tuto.png",
              scale: 15,
            ),
            label: "Tutorial",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/w3.png",
              scale: 14,
            ),
            label: "W3Schools",
          ),
        ],
      ),
    );
  }
}
