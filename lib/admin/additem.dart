import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lastminutesapp/service/database.dart';
import 'package:lastminutesapp/uihelper/hepler.dart';
import 'package:random_string/random_string.dart';

class Product extends StatefulWidget {
  const Product({super.key});
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final ImagePicker picker = ImagePicker();
  File? Selectimage;
  TextEditingController productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productdescription = TextEditingController();

  Future Getimage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    Selectimage = File(image!.path);
    setState(() {});
  }

  additem() async {
    if (productname != "" &&
        Selectimage != null &&
        productdescription != "" &&
        productprice != "" &&
        categoryItem != "") {
      String Addid = randomAlphaNumeric(10);
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("blogimag")
          .child(Addid);
      final UploadTask task = firebaseStorageRef.putFile(Selectimage!);
      var downlodurl = await (await task).ref.getDownloadURL();
      Map<String, dynamic> addProduct = {
        "Name": productname.text,
        "ImgUrl": downlodurl,
        "Price": productprice.text,
        "Description": productdescription.text,
      };
      await database().addProduct(addProduct, value!).then((value) {
        setState(() {
          productname.text = "";
          productprice.text = "";
          productdescription.text = "";
          Selectimage = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Add Successfully"),
            backgroundColor: Colors.green,
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              "Fill data in required filled",
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.orangeAccent,
          behavior: SnackBarBehavior.floating,
          elevation: 6,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  String? value;
  final List<String> categoryItem = [
    'Mobile',
    "Watch",
    "Laptop",
    'Tv',
    "EarBuds",
    "Charger",
    "Headphone",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Add Product",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Upload the product image",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: GestureDetector(
                onTap: () {
                  Getimage();
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child:
                        (Selectimage == null)
                            ? Icon(Icons.camera_alt_outlined)
                            : Image.file(Selectimage!, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            /*: Material(
                  //  elevation: 4.0,
                 // borderRadius: BorderRadius.circular(7),
                  child: Center(
                    child: GestureDetector(
                      onTap: Getimage,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Image.file(Selectimage!,fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),*/
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Text(
                "Product name",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: productname,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "Product category",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text(
                      "Select Category",
                      style: TextStyle(fontSize: 16),
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: 35,
                    ),
                    value: value,
                    items:
                        categoryItem
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(),
                                ), // FIXED HERE
                              ),
                            )
                            .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        value = newValue;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Text(
                "Product Price",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: productprice,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Text(
                "Product Description",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Container(
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: productdescription,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 25),
                width: 250,
                height: 50,
                child: UiHelper.logbutton(
                  () {
                    additem();
                  },
                  "Add Item",
                  Colors.green,
                  Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
