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
      style: ElevatedButton.styleFrom(backgroundColor: color),
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
}
