import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CabPayment(),
    );
  }
}

class CabPayment extends StatefulWidget {
  @override
  _CabPaymentState createState() => _CabPaymentState();
}

class _CabPaymentState extends State<CabPayment> {
  TextEditingController payController=TextEditingController();
  TextEditingController codeController=TextEditingController();
  late Razorpay _razorpay;
  var _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();

    // Initializing Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _verification();
  }
  String vcode="";
  void _verification()async{
    SharedPreferences sh =
        await SharedPreferences.getInstance();
    setState(() {
      vcode=sh.getString("vcode").toString();
    });
  }
  @override
  void dispose() {
    // Disposing Razorpay instance to avoid memory leaks
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle successful payment
    print("Payment Successful: ${response.paymentId}");
    senddata();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print("Error in Payment: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    print("External Wallet: ${response.walletName}");
  }

  void _openCheckout() {
    var options = {
      'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
      'amount': double.parse(payController.text)*100, // Amount in paise (e.g. 2000 paise = Rs 20)
      'name': 'Flutter Razorpay Example',
      'description': 'Payment for the product',
      'prefill': {'contact': '9747360170', 'email': 'tlikhil@gmail.com'},
      'external': {
        'wallets': ['paytm'] // List of external wallets
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razorpay Flutter Example'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
          
            child: Column(
            children: [
              SizedBox(height: 160,),
              TextFormField(
                validator: (value) {
                  if (value.toString() !=vcode ){
                    return "Verification code does not match";
                  }
                  return null;
                },
                controller:codeController,decoration: InputDecoration(labelText:'Enter your verification code',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),prefixIcon: Icon(Icons.verified_outlined),),),
              SizedBox(height: 10,),
          
              TextFormField(
                validator: RequiredValidator(errorText: 'this field is required'),
                controller:payController,decoration: InputDecoration(labelText:'Enter Amount..',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),prefixIcon: Icon(Icons.currency_rupee),),),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState !.validate()) {
                    _openCheckout();
                  };
                },
                child: Text('Make Payment'),
              ),
            ],
          ),
          ),
        )
      ),
    );
  }
  void senddata()async {
    String pay=payController.text;
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String rid=sh.getString('rid').toString();

    final urls = Uri.parse('$url/user_send_cab_payment/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'amount': pay,
        'cid':rid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          // Fluttertoast.showToast(
          //     msg: 'Feedback Send Sussessfully');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserHome(title: ''),
              ));
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }


}