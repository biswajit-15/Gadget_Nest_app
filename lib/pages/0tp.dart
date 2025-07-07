import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastminutesapp/home/buttomnav.dart';
import 'package:lastminutesapp/uihelper/hepler.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class otp extends StatefulWidget {
  String Mobile;
  String receiveotp;
  otp({super.key, required this.Mobile, required this.receiveotp});

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  var otp = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            "OTP verification",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              "We've sent a verification code to",
              style: TextStyle(fontSize: 17),
            ),
          ),
          Center(
            child: Text(
              widget.Mobile,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 300,
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              controller: otp,
              pinTheme: PinTheme(fieldHeight: 50, fieldWidth: 40),
            ),
          ),
          UiHelper.logbutton(
            () async {
              try {
                PhoneAuthCredential credential =
                    await PhoneAuthProvider.credential(
                      verificationId: widget.receiveotp,
                      smsCode: otp.text.toString(),
                    );
                auth.signInWithCredential(credential).then((value) async {
                  var value = await SharedPreferences.getInstance();
                  value.setBool("loginfo", true);
                  value.setString("UserMobile", widget.Mobile);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Buttomnav()),
                  );
                });
              } catch (e) {
                //print("Verification failed: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("OTP Verification Failed")),
                );
              }
            },
            "Verify",
            Colors.green,
            Colors.black,
          ),
        ],
      ),
    );
  }
}
