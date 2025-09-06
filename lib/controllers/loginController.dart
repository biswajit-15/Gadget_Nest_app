import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lastminutesapp/home/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/buttomnav.dart';
import '../pages/0tp.dart';

class UserLoginController extends GetxController {
  var mobile = TextEditingController();
  var bottomColor = Colors.white.obs;
  var isValid = false.obs;
  final auth = FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
    mobile.addListener(() {
      if (mobile.text.length == 10) {
        bottomColor.value = Colors.green;
        isValid.value = true;
      } else {
        bottomColor.value = Colors.white;
        isValid.value = false;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mobile.dispose();
    super.dispose();
  }

  void sendOtp() async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: '+91${mobile.text.trim()}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await auth.signInWithCredential(credential);
            Get.offAll(() => Home());
          } catch (e) {
            Get.snackbar("Error", "Sign-in failed: $e");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Error", e.message ?? "Verification failed");
        },
        codeSent: (String verificationId, int? token) {
          try {
            Get.to(
              () => otp(
                Mobile: mobile.text.trim(),
                receiveOtp: verificationId.toString(),
              ),
            );
          } catch (e) {
            Get.snackbar("Error", "Navigation failed: $e");
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Get.snackbar("Error", "Unexpected error: $e");
    }
  }

  Future<void> googleSignIn() async {
    String webclient =
        "451320075474-lt5g1vbtpvv9e24mjtrgjs2vchd34kvp.apps.googleusercontent.com";
    try {
      GoogleSignIn signIn = GoogleSignIn.instance;
      await signIn.initialize(serverClientId: webclient);
      GoogleSignInAccount? account = await signIn.authenticate();
      GoogleSignInAuthentication googleAuth = account.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      auth.signInWithCredential(credential);
      var value = await SharedPreferences.getInstance();
      value.setBool("loginfo", true);
      value.setString("UserEmail", account.email);
      Get.offAll(() => Buttomnav());
    } catch (e) {
      Get.snackbar(
        "Failed, try again later", // Title
        e.toString(), // Message
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
