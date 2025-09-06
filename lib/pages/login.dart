import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastminutesapp/admin/login.dart';
import 'package:lastminutesapp/controllers/loginController.dart';
import 'package:lastminutesapp/uihelper/all_const_variabel.dart';
import 'package:lastminutesapp/uihelper/hepler.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(UserLoginController());
   @override
  Widget build(BuildContext context) {
     final screenHeight = MediaQuery.of(context).size.height;
     final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.yellow.shade700,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight *0.49,
              child: Image.asset(const_value.logImage, fit: BoxFit.cover),
            ),
            Text(
              "India's last minute app",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth *0.08,
                shadows: [
                  Shadow(
                    offset: Offset(0.5, 0.5),
                    blurRadius: 1.5,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap:() => Get.offAll(AdminLogin()),
                child: Text(
                  "Admin log",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.045,
                    color: Colors.green.shade900,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Login or Sign in",
                style: TextStyle(fontWeight: FontWeight.w400,
                  fontSize: screenWidth * 0.050,
                ),
              ),
            ),
            UiHelper.textField(controller.mobile),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: screenHeight * 0.057,
                  width: double.infinity,
                  child: UiHelper.logbutton(
                    controller.isValid.value
                        ? () => controller.sendOtp()
                        : () {},
                    "Continue",
                    controller.bottomColor.value,
                    Colors.black,
                  ),
                ),
              ),
            ),
            Text(
              "Or",
              style: TextStyle(fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.04,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: screenHeight * 0.057,
                width: double.infinity,
                child: UiHelper.logbutton(
                  () {
                    controller.googleSignIn();
                  },
                  "login with Google",
                  Colors.blue.shade700,
                  Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
