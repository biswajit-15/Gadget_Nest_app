import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastminutesapp/service/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cart extends StatefulWidget {
  const cart({super.key});

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  Stream? orderdetails;
  loadorder() async {
    var value = await SharedPreferences.getInstance();
    String? Mobile = value.getString("UserMobile");
    String? Email = value.getString("UserEmail");
    orderdetails = await database().getorder(
      Mobile.toString(),
      Email.toString(),
    );
    setState(() {});
  }

  void initState() {
    // TODO: implement initState
    loadorder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: Text("Order Details"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade300,
      body: StreamBuilder(
        stream: orderdetails,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                itemBuilder: (context, index) {
                  DocumentSnapshot Data = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 7),
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            child: ClipRRect(
                              child: Image.network(
                                Data["Image"],
                                fit: BoxFit.cover,
                                width: 90,
                                height: 120,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Data["Name"],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Price: ₹${Data["price"]}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "Status: ${Data["Status"]}",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data.docs.length,
              )
              : Container();
        },
      ),
    );
  }
}
