import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastminutesapp/service/database.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Producrdetails extends StatefulWidget {
  String imgurl, price, name, details;
  Producrdetails({
    super.key,
    required this.name,
    required this.imgurl,
    required this.details,
    required this.price,
  });
  @override
  State<Producrdetails> createState() => _ProducrdetailsState();
}

class _ProducrdetailsState extends State<Producrdetails> {
  String? email, Mobile, Address;
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    // Set event handlers
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    loadsp();
  }

  void loadsp() async {
    var value = await SharedPreferences.getInstance();
    email = value.getString("UserEmail");
    Mobile = value.getString("UserMobile");
    Address = value.getString("UserAddress");
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Successful: ${response.paymentId}");
    // Show success dialog or push to order summary screen
    Map<String, dynamic> details = {
      "OderId": response.paymentId,
      "Image": widget.imgurl,
      "price": widget.price,
      "Date": DateTime.now(),
      "Name": widget.name,
      "Email": email,
      "Number": Mobile,
      "Status": "Processing",
    };
    await database().addCart(details, Mobile.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    print("Payment Failed: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Selected: ${response.walletName}");
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(widget.imgurl, fit: BoxFit.contain),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${widget.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(widget.details, style: TextStyle(fontSize: 15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 25,
                      right: 20,
                    ),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if (Mobile == null && Address == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Fill User Details First"),
                              ),
                            );
                          } else {
                            openCheckout();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text(
                          "Buy Now",
                          style: TextStyle(color: Colors.white, fontSize: 20),
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

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_x6GNCH7uTtYL9U', // ← Use your own Razorpay Key
      'amount': calculate() * 100, // Amount in paise (50000 = ₹500)
      'name': 'Last Minutes Store',
      'description': 'Buy Electronics',
      'external': {
        'wallets': ['paytm'],
      },
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  calculate() {
    int price = int.parse(widget.price);
    return price;
  }
}
