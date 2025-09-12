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
  final PageController _bannerController = PageController();
  int _currentBannerIndex = 0;
  var Catagory = [
    {"img": "assets/images/Adobe Express - file (11).png", "item": "Mobile"},
    {"img": "assets/images/Adobe Express - file (2).png", "item": "Watch"},
    {"img": "assets/images/Adobe Express - file (10).png", "item": "Laptop"},
    {"img": "assets/images/Adobe Express - file (4).png", "item": "Tv"},
    {"img": "assets/images/Adobe Express - file (5).png", "item": "EarBuds"},
    {"img": "assets/images/Adobe Express - file (12).png", "item": "Charger"},
    {"img": "assets/images/Adobe Express - file (7).png", "item": "Headphone"},
  ];

  // Banner data
  final List<Map<String, dynamic>> banners = [
    {
      "title": "\n  Get 31% Off Your \n  First Order",
      "image": const_value.galaxyS24,
      "color": Colors.green,
      "buttonText": "BUY NOW"
    },
    {
      "title": "\n  New Arrivals \n  Just In!",
      "image": const_value.photo7, // Add your image path
      "color": Colors.blue,
      "buttonText": "SHOP NOW"
    },
    {
      "title": "\n  Free Shipping \n  On All Orders",
      "image": const_value.photo11, // Add your image path
      "color": Colors.orange,
      "buttonText": "EXPLORE"
    }
  ];

  @override
  void initState() {
    super.initState();
    controller.getName();

    // Auto-scroll banners
    _startBannerTimer();
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  void _startBannerTimer() {
    Future.delayed(Duration(seconds: 5), () {
      if (_bannerController.hasClients) {
        if (_currentBannerIndex < banners.length - 1) {
          _bannerController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _bannerController.animateToPage(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
        _startBannerTimer();
      }
    });
  }

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

                // Banner Slider
                Container(
                  height: 180,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _bannerController,
                        itemCount: banners.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentBannerIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return UiHelper.banner(
                            banners[index]["title"],
                            banners[index]["image"],
                            banners[index]["color"],
                            banners[index]["buttonText"],
                          );
                        },
                      ),

                      // Banner Indicators
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(banners.length, (index) {
                            return Container(
                              width: 8,
                              height: 8,
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentBannerIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
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