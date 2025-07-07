import 'package:flutter/material.dart';
import 'package:lastminutesapp/pages/login.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 80, left: 10, right: 10),
          child: Column(
            children: [
              Image.asset("assets/images/headphone.png"),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    width: double.infinity,
                    height: 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: Color(0xFFE8F5E9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                            0.1,
                          ), // soft dark shadow
                          blurRadius: 12, // smooth blur
                          spreadRadius: 1,
                          offset: Offset(6, 6),
                        ),
                      ],
                    ),

                    child: Text(
                      ' One tap,\n and your tech is \n on the way',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 280,
                    left: 270,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Login();
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Color(0xFF2E7D32),
                        ),
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
