import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lastminutesapp/producrdetails.dart';
import 'package:lastminutesapp/service/database.dart';

class productlist extends StatefulWidget {
  final String Category;
  const productlist({super.key, required this.Category});

  @override
  State<productlist> createState() => _productlistState();
}

class _productlistState extends State<productlist> {
  Stream? CategoryStream;

  getload() async {
    CategoryStream = await database().getproductlist(widget.Category);
    setState(() {});
  }

  @override
  void initState() {
    getload();
    super.initState();
  }

  Widget allProducts() {
    return CategoryStream == null
        ? const Center(child: CircularProgressIndicator())
        : StreamBuilder(
      stream: CategoryStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return const Center(child: Text("No products found."));
        }

        return GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.55,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Producrdetails(
                        imgurl: ds["ImgUrl"],
                        details: ds["Description"],
                        name: ds["Name"],
                        price: ds["Price"],
                      );
                    },
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: const EdgeInsets.all(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image with loading indicator
                    Container(
                      width: 210,
                      height: 240,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            ds["ImgUrl"],
                            width: 210,
                            height: 240,
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey.shade200,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.broken_image, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        ds["Name"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '₹${ds["Price"]}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Producrdetails(
                                imgurl: ds["ImgUrl"],
                                details: ds["Description"],
                                name: ds["Name"],
                                price: ds["Price"],
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 53,
                        width: double.infinity,
                        color: Colors.green,
                        child: const Center(
                          child: Text(
                            "View Details",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: Text(widget.Category),
      ),
      body: Column(children: [Expanded(child: allProducts())]),
    );
  }
}