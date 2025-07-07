import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  const Details({super.key});
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController Name = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Gender = TextEditingController();
  TextEditingController Mobile = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdetails();
  }

  getdetails() async {
    var value = await SharedPreferences.getInstance();
    setState(() {
      Name.text = value.getString("UserName") ?? "FIll The Details";
      Email.text = value.getString("UserEmail") ?? "FIll The Details";
      Address.text = value.getString("UserAddress") ?? "FIll The Details";
      Gender.text = value.getString("UserGender") ?? "FIll The Details";
      Mobile.text = value.getString("UserMobile") ?? "FIll The Details";
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("My Details"),
        //  centerTitle: true,
        backgroundColor: Colors.grey.shade200,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(30),
                  bottomEnd: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              height: 600,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: TextField(
                      controller: Name,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: Mobile,
                      decoration: InputDecoration(
                        labelText: "Mobile",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: Email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: Gender,
                      decoration: InputDecoration(
                        labelText: "Gender",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: Address,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Address",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var ditails = await SharedPreferences.getInstance();
                      ditails.setString("UserName", Name.text);
                      ditails.setString("UserEmail", Email.text);
                      ditails.setString("UserGender", Gender.text);
                      ditails.setString("UserAddress", Address.text);
                      ditails.setString("UserMobile", Mobile.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(
                              "Profile Update",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          backgroundColor: Colors.green.shade500,
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(30),
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(10),
                          topEnd: Radius.circular(10),
                        ),
                        color: Colors.green,
                      ),
                      child: Center(
                        child: Text(
                          "Update Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
