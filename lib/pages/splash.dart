import 'package:lastminutesapp/home/buttomnav.dart';
import 'package:lastminutesapp/pages/onboding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    share();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  ///Used shared preference
  void share() async {
    var value = await SharedPreferences.getInstance();
    var val1 = value.getBool("loginfo");
    if (val1 != true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Onboarding()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Buttomnav()),
      );
    }
  }
}
