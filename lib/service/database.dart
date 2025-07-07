import 'package:cloud_firestore/cloud_firestore.dart';

class database {
  // Add product
  Future addProduct(
    Map<String, dynamic> userInfoMap,
    String categoryName,
  ) async {
    return await FirebaseFirestore.instance
        .collection(categoryName)
        .add(userInfoMap);
  }

  // Add order to history
  Future addCart(Map<String, dynamic> orderDetails, String mobile) async {
    return await FirebaseFirestore.instance
        .collection("Order details")
        .add(orderDetails);
  }

  // Get customer order
  Stream<QuerySnapshot> getorder(String mobile, String email) {
    return FirebaseFirestore.instance
        .collection("Order details")
        .where("Number", isEqualTo: mobile)
        .where("Email", isEqualTo: email)
        .snapshots();
  }

  // Admin get 'Processing' orders
  Stream<QuerySnapshot> getAdminorder() {
    return FirebaseFirestore.instance
        .collection("Order details")
        .where("Status", isEqualTo: "Processing")
        .snapshots();
  }

  // Admin get 'Completed' orders
  Stream<QuerySnapshot> getAdmincompleteorder() {
    return FirebaseFirestore.instance
        .collection("Order details")
        .where("Status", isEqualTo: "Delivered")
        .snapshots();
  }

  // Update order status
  Future<void> Updatestatus(String mobile, String orderId) async {
    return await FirebaseFirestore.instance
        .collection("Order details")
        .doc(orderId)
        .update({"Status": "Delivered"});
  }

  Future<Stream<QuerySnapshot>> getproductlist(String Categoryname) async {
    return FirebaseFirestore.instance.collection(Categoryname).snapshots();
  }
}
