import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastminutesapp/service/database.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Producrdetails extends StatefulWidget {
  final String imgurl, price, name, details;

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
  bool _isImageLoading = true;

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
    setState(() {});
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Successful: ${response.paymentId}");
    // Show success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Payment Successful"),
          content: Text("Your order has been placed successfully. Order ID: ${response.paymentId}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment failed: ${response.message ?? 'Unknown error'}"),
        backgroundColor: Colors.red,
      ),
    );
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
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ),
        title: Text(
          "Product Details",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with loading state
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey.shade100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_isImageLoading)
                    const CircularProgressIndicator(),

                  Image.network(
                    widget.imgurl,
                    fit: BoxFit.contain,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (_isImageLoading) {
                            setState(() {
                              _isImageLoading = false;
                            });
                          }
                        });
                        return child;
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.broken_image, color: Colors.grey, size: 50),
                    ),
                  ),
                ],
              ),
            ),

            // Product Info Card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '₹${widget.price}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Product Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.details,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // User Info Card
            if (Mobile != null || Address != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Delivery Info",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (Mobile != null)
                          Row(
                            children: [
                              Icon(Icons.phone, color: Colors.blue.shade700, size: 20),
                              const SizedBox(width: 10),
                              Text(
                                Mobile!,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        if (Address != null) ...[
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on, color: Colors.blue.shade700, size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  Address!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

            // Buy Now Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (Mobile == null || Address == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Please complete your profile details first"),
                          backgroundColor: Colors.orange.shade700,
                          action: SnackBarAction(
                            label: "OK",
                            onPressed: () {},
                          ),
                        ),
                      );
                    } else {
                      openCheckout();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_x6GNCH7uTtYL9U', // Use your own Razorpay Key
      'amount': calculate() * 100, // Amount in paise
      'name': 'Last Minutes Store',
      'description': widget.name,
      'prefill': {
        'contact': Mobile,
        'email': email
      },
      'external': {
        'wallets': ['paytm'],
      },
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  calculate() {
    int price = int.parse(widget.price);
    return price;
  }
}