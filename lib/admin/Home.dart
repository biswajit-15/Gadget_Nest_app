import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastminutesapp/admin/Complate_order.dart';
import 'package:lastminutesapp/admin/Order.dart';
import 'package:lastminutesapp/admin/additem.dart';
import 'package:lastminutesapp/pages/login.dart';

class Adminhome extends StatefulWidget {
  const Adminhome({super.key});
  @override
  State<Adminhome> createState() => _AdminhomeState();
}

class _AdminhomeState extends State<Adminhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 25),
            child: GestureDetector(
              onTap: () {
                //Now this profile are not crated because i used logout button
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
              child: CircleAvatar(child: Icon(Icons.account_circle, size: 50)),
            ),
          ),
        ],
        backgroundColor: Colors.purple.shade50,
        title: Text("Admin Panel"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Divider(thickness: 0.8, height: 0.9, color: Colors.black),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Product();
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_shopping_cart),
                        Text("Add Item"),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AdminOrder();
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.pending_actions),
                        Text("Order Pending"),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return OderDone();
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.done), Text("Order Complete")],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
