import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smart_cab/ambulance/ahome.dart';
import 'package:smart_cab/ambulance/ambulance_signup.dart';
import 'package:smart_cab/driver/home.dart';
import 'package:smart_cab/driver_signup.dart';

import 'package:smart_cab/user/home.dart';
import 'package:smart_cab/user_signup.dart';

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
      home: const MyLoginPage(title: 'Login'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  _MyLoginPageState()
  {
    userController.text="ss@gmail.com";
    passController.text="1";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyLoginPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Align(
          child: Text(widget.title, textAlign: TextAlign.center),
          alignment: Alignment.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            key: _formkey,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100,),
              TextFormField(
                validator: (value) => validateuser(String, value!),
                controller: userController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: 11,
              ),
              TextFormField(
                validator: (value) => validatepassword(String, value!),
                controller: passController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: 4,
              ),

              ElevatedButton(
                  onPressed: () {
                    senddata();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MyProfile(title: 'Profile'),
                    //     ));
                  },
                  child: Text("LOGIN")),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MySignPage(
                            title: "Signup",
                          ),
                        ));
                  },
                  child: Text("New Driver?Signup here")),
              SizedBox(
                height: 4,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserSignup(
                            title: "Signup",
                          ),
                        ));
                  },
                  child: Text("New User?Signup here")),

              SizedBox(
                height: 4,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AmbulanceSignupPage(
                            title: "Signup",
                          ),
                        ));
                  },
                  child: Text("New Ambulance Driver?Signup here")),
              // TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => MySignPage(
              //               title: "Signup",
              //             ),
              //           ));
              //     },
              //     child: Text("Signup")),
              // TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => MySignPage(
              //               title: "Signup",
              //             ),
              //           ));
              //     },
              //     child: Text("Signup"))
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [Text("New User?Signup")],
              // ),
              // const Text(
              //   'You have pushed the button this many times:',
              // ),
              // Text(
              //   '$_counter',
              //   style: Theme.of(context).textTheme.headline4,
              // ),
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

  void senddata() async {
    String username = userController.text;
    String password = passController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/and_login/');
    try {
      final response = await http
          .post(urls, body: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == "ok") {
          String lid = jsonDecode(response.body)['lid'];
          String type = jsonDecode(response.body)['type'];
          if (type == "driver") {
            sh.setString('lid', lid);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DriverHome(title: ""),
                ));
          } else if (type == "user") {
            sh.setString('lid', lid);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserHome(title: ""),
                ));
          }else if(type == "ambulance"){
            sh.setString('lid', lid);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AmbulanceHome(title: ""),
                ));
          }
          else {
            Fluttertoast.showToast(msg: "notfound");
          }
        } else {
          Fluttertoast.showToast(msg: "Invalid");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  String? validateuser(String, value) {
    if (value.isEmpty) {
      return "Please enter username";
    }
    return null;
  }

  String? validatepassword(String, value) {
    if (value.isEmpty) {
      return "Please enter password";
    }
    return null;
  }

  // Future<void> _launchUrl(l,k) async {
  //   String url="htm.com/q=?"+l+','+k;
  //   if (!await launchUrl(url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }
}
