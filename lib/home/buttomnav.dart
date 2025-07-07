import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastminutesapp/home/Cart.dart';
import 'package:lastminutesapp/home/Home.dart';
import 'package:lastminutesapp/home/profile.dart';

class Buttomnav extends StatefulWidget {
  const Buttomnav({super.key});

  @override
  State<Buttomnav> createState() => _ButtomnavState();
}

class _ButtomnavState extends State<Buttomnav> {
  int currentIndex = 0;
  List<Widget> page = [Home(), cart(), profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: CupertinoColors.lightBackgroundGray,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 200),
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.shopping_bag_outlined, color: Colors.white),
          Icon(Icons.account_circle, color: Colors.white),
        ],
      ),
      body: page[currentIndex],
    );
  }
}
