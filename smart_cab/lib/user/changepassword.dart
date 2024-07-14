import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smart_cab/login.dart';
import 'package:smart_cab/newlogintemp.dart';

var _formKey = GlobalKey<FormState>();


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const User_Change_Password(title: 'Review and Rating'),
    );
  }
}

class User_Change_Password extends StatefulWidget {
  const User_Change_Password({super.key, required this.title});

  final String title;

  @override
  State<User_Change_Password> createState() => _User_Change_PasswordState();
}

class _User_Change_PasswordState extends State<User_Change_Password> {
  String _rating = "";
  TextEditingController oldController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  // TextEditingController ratingController = TextEditingController();

  // int _counter = 0;
  //
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the User_Change_Password object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Align(
          child: Text(widget.title, textAlign: TextAlign.center),
          alignment: Alignment.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: oldController,
                  decoration: InputDecoration(
                    labelText: 'Current password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  validator: (v){
                    if(v!.isEmpty){
                      return 'Must enter valid password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: newController,
                  decoration: InputDecoration(
                    labelText: 'New password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  validator: (v){
                    if(v!.isEmpty){
                      return 'Must enter Password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: confirmController,
                  decoration: InputDecoration(
                    labelText: 'Re-Enter Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid password!';
                    }
                    else if(value!=newController.text)
                    {
                      return 'Passwords Missmatch ';
                    }
                    return null;
                  },

                ),
              ),



              // TextField(
              //   decoration: InputDecoration(
              //     labelText: 'Password',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              SizedBox(
                height: 4,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(50),
              //   child: RatingBar.builder(
              //     initialRating: 1,
              //     minRating: 1,
              //     direction: Axis.horizontal,
              //     allowHalfRating: true,
              //     itemCount: 5,
              //     itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              //     itemBuilder: (context, _) => Icon(
              //       Icons.star,
              //       color: Colors.amber,
              //     ),
              //     onRatingUpdate: (rating) {
              //       setState(() {
              //         _rating = rating.toString();
              //       });
              //     },
              //   ),
              // ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState !.validate()) {
                      String old = oldController.text.toString();
                      String newp = newController.text.toString();
                      String confirm = confirmController.text.toString();
                      // String rating = _rating;
                      SharedPreferences sh = await SharedPreferences
                          .getInstance();
                      String url = sh.getString('url').toString();
                      String lid = sh.getString('lid').toString();

                      final urls = Uri.parse('$url/user_change_password/');
                      try {
                        final response = await http.post(urls, body: {
                          'old': old,
                          'new': newp,
                          'confirm': confirm,
                          // 'did': sh.getString("did").toString(),
                          'lid': lid,
                        });
                        if (response.statusCode == 200) {
                          String status = jsonDecode(response.body)['status'];
                          if (status == 'ok') {
                            Fluttertoast.showToast(msg: ' Updated');
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(title: ""),));
                          } else {
                            Fluttertoast.showToast(msg: 'User no found ');
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Network Error');
                        }
                      } catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    }else{
                      return null;
                    }},
                  child: Text("send"),
                ),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       // Route
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => MyLoginPage(title: 'Login'),
              //           ));
              //     },
              //     child: Text('Submit'))
            ],
          ),

        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
