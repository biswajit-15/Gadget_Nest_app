import 'package:flutter/material.dart';

class UiHelper {
  static textField(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Enter Mobile Number",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
          prefixIcon: Icon(Icons.call, color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  static logbutton(
    VoidCallback onpress,
    String text,
    Color color,
    Color fcolor,
  ) {
    return ElevatedButton(
      onPressed: () {
        onpress();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,),
      child: Text(text, style: TextStyle(color: fcolor)),
    );
  }

  static searchfild(String hint, Icon prefix, Color Color) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: TextField(
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 13),
              border: InputBorder.none,
              hintText: hint,
              prefixIcon: prefix,
            ),
          ),
        ),
      ),
    );
  }

  static imagebulider({required String img}) {
    return Image.asset('$img', width: 80, height: 80);
  }

  static Textfieldadmin(TextEditingController controller, String Hinttext) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: Hinttext,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
  static texts(String text,double textSize,FontWeight fontWeight,Color? color){
    return Text(text,style:  TextStyle(fontWeight: fontWeight,fontSize: textSize,color: color),);
  }
  static banner(String title,String image,Color backgroundColor,String buttonTitle){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: backgroundColor,
            ),
            height: 150,
            width: double.infinity,
            child: Text(
              //"\n  Get 31% Off Your \n  First Order",
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Positioned(
            left: 250,
            child: Image.asset(
              //"assets/images/Adobe Express - file (11).png",
              image,
              width: 110,
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  buttonTitle,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
