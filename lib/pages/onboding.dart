import 'package:flutter/material.dart';
import 'package:lastminutesapp/pages/login.dart';
import 'package:lastminutesapp/uihelper/Appcolor.dart';
import 'package:lastminutesapp/uihelper/all_const_variabel.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final fontSize = ((size.width + size.height) * 0.04).clamp(20.0, 32.0);

    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.04),
              Image.asset(
                const_value.onbordImage,
              ),
              SizedBox(height: isLandscape ? size.height * 0.05 : size.height * 0.12),

              // Container responsive height / width
              Container(
                padding: const EdgeInsets.all(16),
                constraints: BoxConstraints(
                  minHeight: size.height * 0.25,
                  maxHeight: size.height * (isLandscape ? 0.6 : 0.30),
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.lightGreen,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(51, 0, 0, 0), // 51 ≈ 20% opacity
                      blurRadius: 16,
                      spreadRadius: 1,
                      offset: const Offset(6, 6),
                    ),

                  ],
                ),
                child: Stack(
                  children: [
                    // Text auto wrap
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'One tap \nand your tech is \non the way',
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Arrow Button bottom-right
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginPage()),
                          );
                        },
                        child: Container(
                          width: isLandscape ? (size.height * 0.25).clamp(60.0, 100.0) : (size.width * 0.25).clamp(60.0, 100.0),
                          height: isLandscape ? (size.height * 0.15).clamp(40.0, 80.0) : (size.height * 0.07).clamp(40.0, 80.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppColors.primaryGreen,
                          ),
                          child:  Icon(Icons.arrow_forward_outlined, size: 40),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
