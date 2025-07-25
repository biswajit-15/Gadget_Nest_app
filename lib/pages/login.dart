import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lastminutesapp/admin/login.dart';
import 'package:lastminutesapp/home/buttomnav.dart';
import 'package:lastminutesapp/pages/0tp.dart';
import 'package:lastminutesapp/uihelper/hepler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var mobile = TextEditingController();
  Color Bottomc = Colors.white;
  bool isValid = false;
  final auth = FirebaseAuth.instance;
  FirebaseAuth auth1 = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobile.addListener(() {
      if (mobile.text.length == 10) {
        setState(() {
          Bottomc = Colors.green;
          isValid = true;
        });
      } else {
        setState(() {
          Bottomc = Colors.white;
          isValid = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade700,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 440,
                child: Image.asset(
                  "assets/images/delivery.png",
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Text(
                  "India's last minute app",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    shadows: [
                      Shadow(
                        offset: Offset(0.5, 0.5),
                        blurRadius: 1.5,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AdminLogin();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Admin",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.green.shade900,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Login or Sign in",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                ),
              ),

              UiHelper.textField(mobile),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: UiHelper.logbutton(
                    () async {
                      auth.verifyPhoneNumber(
                        phoneNumber: '+91${mobile.text.trim()}',
                        verificationCompleted: (_) {},
                        verificationFailed: (e) {
                          print(
                            "Verification failed: ${e.code} - ${e.message}",
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Verification failed: ${e.message}",
                              ),
                            ),
                          );
                        },
                        codeSent: (String verificationId, int? token) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => otp(
                                    Mobile: mobile.text.trim(),
                                    receiveotp: verificationId,
                                  ),
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    "Continue",
                    Bottomc,
                    Colors.black,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Or",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: UiHelper.logbutton(
                    () async {
                      googlesigin();
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
      ),
    );
  }

  void googlesigin() async {
    String webclient =
        "451320075474-lt5g1vbtpvv9e24mjtrgjs2vchd34kvp.apps.googleusercontent.com";
    try 
      GoogleSignIn signIn = GoogleSignIn.instance;
      await signIn.initialize(serverClientId: webclient);
      GoogleSignInAccount account = await signIn.authenticate();
      GoogleSignInAuthentication googleauth = account.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleauth.idToken,
      );

      auth.signInWithCredential(credential);
      var value = await SharedPreferences.getInstance();
      value.setBool("loginfo", true);
      value.setString("UserEmail", account.email);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Buttomnav()),
        (route) => false,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
