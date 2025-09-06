import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastminutesapp/productlist.dart';
import 'package:lastminutesapp/uihelper/all_const_variabel.dart';
import 'package:lastminutesapp/uihelper/hepler.dart';
import '../controllers/homeController.dart';

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(UserHomeController());
  var Catagory = [
    {"img": "assets/images/Adobe Express - file (11).png", "item": "Mobile"},
    {"img": "assets/images/Adobe Express - file (2).png", "item": "Watch"},
    {"img": "assets/images/Adobe Express - file (10).png", "item": "Laptop"},
    {"img": "assets/images/Adobe Express - file (4).png", "item": "Tv"},
    {"img": "assets/images/Adobe Express - file (5).png", "item": "EarBuds"},
    {"img": "assets/images/Adobe Express - file (12).png", "item": "Charger"},
    {"img": "assets/images/Adobe Express - file (7).png", "item": "Headphone"},
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.getName();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      backgroundColor: CupertinoColors.lightBackgroundGray,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => UiHelper.texts(
                              "Hey, ${controller.username.value}",
                              25,
                              FontWeight.bold,
                              Colors.black,
                            ),
                          ),
                          UiHelper.texts(
                            controller.gettingS.value,
                            20,
                            FontWeight.bold,
                            Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          const_value.profileImage,
                          fit: BoxFit.cover,
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                UiHelper.searchfild(
                  "Search any item",
                  Icon(Icons.search),
                  Colors.white,
                ),
                UiHelper.banner(
                  "\n  Get 31% Off Your \n  First Order",
                  const_value.galaxyS24,
                  Colors.green,
                  "BUY NOW",
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UiHelper.texts(
                        "Categories",
                        18,
                        FontWeight.bold,
                        Colors.black,
                      ),
                      UiHelper.texts(
                        "See all",
                        18,
                        FontWeight.w600,
                        Colors.red,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 15),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 9),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return productlist(
                                          Category:
                                              Catagory[index]["item"]
                                                  .toString(),
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 100,
                                  height: 125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      UiHelper.imagebulider(
                                        img: Catagory[index]["img"].toString(),
                                      ),
                                      Text(
                                        Catagory[index]["item"].toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: Catagory.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UiHelper.texts(
                        "All Products",
                        20,
                        FontWeight.bold,
                        Colors.black,
                      ),
                      UiHelper.texts(
                        "See all",
                        18,
                        FontWeight.w600,
                        Colors.red,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(context,MaterialPageRoute(builder: (context) => ));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    "assets/images/Adobe Express - file (7).png",
                                    width: 100,
                                    height: 120,
                                  ),
                                  Text(
                                    "Headphone",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "\$1000",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          color: Colors.deepOrange,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  "assets/images/Adobe Express - file (12).png",
                                  width: 100,
                                  height: 120,
                                ),
                                Text(
                                  "Charger",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$300",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.deepOrange,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  "assets/images/Adobe Express - file (2).png",
                                  width: 100,
                                  height: 120,
                                ),
                                Text(
                                  "Smart watch",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$1000",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.deepOrange,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  "assets/images/Adobe Express - file (11).png",
                                  width: 100,
                                  height: 120,
                                ),
                                Text(
                                  "Mobile",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$9000",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.deepOrange,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
