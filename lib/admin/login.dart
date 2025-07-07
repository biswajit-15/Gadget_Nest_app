import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastminutesapp/admin/Home.dart';
import 'package:lastminutesapp/uihelper/hepler.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});
  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue.shade200),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Image.asset(
                "assets/images/Adobe Express - file (1).png",
                width: 500,
                height: 300,
              ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: Colors.blue.shade200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: Text(
                "Admin Login",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Container(child: UiHelper.Textfieldadmin(user, "User Id")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Container(
                child: UiHelper.Textfieldadmin(password, "Password"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                height: 50,
                width: 300,
               child: ElevatedButton(onPressed: (){
                 Navigator.pushAndRemoveUntil(context,
                   MaterialPageRoute(builder: (_) => Adminhome()), (
                       route) => false,);
               },style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade200), child: Text("Login")),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    FirebaseFirestore.instance.collection("admin").get().then((snapshot) {
      (snapshot).docs.forEach((result) {
        if (result.data()['user'] != user.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Wrong Userid"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ),
          );
        } else if (result.data()['password'] != password.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Wrong Password"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Adminhome();
              },
            ),
          );
        }
      });
    });
  }
}
