

import 'dart:convert';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cab/ambulance/ambulance_signup.dart';
import 'package:smart_cab/driver_signup.dart';
import 'package:smart_cab/main.dart';
import 'package:smart_cab/user/home.dart';
import 'package:animate_do/animate_do.dart';
import 'package:smart_cab/user_signup.dart';

import 'ambulance/ahome.dart';
import 'driver/home.dart';


void main() {
  runApp(const Login());
}

final _formkey = GlobalKey<FormState>();


class Login extends StatelessWidget {
  const Login({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(title: 'Theaf Detection'),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';
  TextEditingController unamecontroller= new TextEditingController();
  TextEditingController passcontroller=new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setLogin();
  }

  void updateLoc(lid) async{
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.enableBackgroundMode(enable: true);
    _locationData = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      _update_location(_locationData.latitude.toString(), _locationData.longitude.toString(), lid);
    });
  }
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyIpPage(title: "IP")));
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill
                        )
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeInUp(duration: Duration(seconds: 1), child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/light-1.png')
                                )
                            ),
                          )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeInUp(duration: Duration(milliseconds: 1200), child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/light-2.png')
                                )
                            ),
                          )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeInUp(duration: Duration(milliseconds: 1300), child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/clock.png')
                                )
                            ),
                          )),
                        ),
                        Positioned(
                          child: FadeInUp(duration: Duration(milliseconds: 1600), child: Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                            ),
                          )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          FadeInUp(duration: Duration(milliseconds: 1800), child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color.fromRGBO(143, 148, 251, 1)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10)
                                  )
                                ]
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color:  Color.fromRGBO(143, 148, 251, 1)))
                                  ),
                                  child: TextFormField(
                                    controller: unamecontroller,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: EmailValidator(errorText: 'Enter a valid email'),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle: TextStyle(color: Colors.grey[700])
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: passcontroller,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Your Password';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: Colors.grey[700])
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                          SizedBox(height: 30,),
                          FadeInUp(
                            duration: Duration(milliseconds: 1900),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ],
                                ),
                              ),
                              child: TextButton( // Change this line
                                onPressed: (){
                                  if (_formkey.currentState!.validate()) {
                                    _send_data();
                                  } else {
                                    return null;
                                  }
                                }, // Add this line
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 50,),
                          FadeInUp(duration: Duration(milliseconds: 2000),

                            child: TextButton( // Change this line
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const UserSignup(
                                            title: "New User?Signup")));
                              }, // Add this line
                              child: Center(
                                  child:Text("New User?Signup", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          FadeInUp(duration: Duration(milliseconds: 2000),

                            child: TextButton( // Change this line
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const MySignPage(
                                            title: "New Driver?Signup")));
                              }, // Add this line
                              child: Center(
                                  child:Text("New Driver?Signup", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          FadeInUp(duration: Duration(milliseconds: 2000),

                            child: TextButton( // Change this line
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const AmbulanceSignupPage(
                                            title: "New Ambulance?Signup")));
                              }, // Add this line
                              child: Center(
                                  child:Text("New Ambulance Driver?Signup", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
  void _send_data() async{


    String uname = unamecontroller.text;
    String password = passcontroller.text;

    if (uname.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill in all fields');
    } else {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();

      final urls = Uri.parse('$url/and_login/');
      try {
        final response = await http.post(urls, body: {
          'username': uname,
          'password': password,
        });
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
              updateLoc(lid.toString());
            } else if (type == "user") {
              sh.setString('lid', lid);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserHome(title: ""),
                  ));
              updateLoc(lid.toString());
            }else if(type == "ambulance"){
              sh.setString('lid', lid);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AmbulanceHome(title: ""),
                  ));
              updateLoc(lid.toString());
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
  }

  void _update_location(lat, lon, lid) async{
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/_update_location/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'lat': lat,
        'lon': lon,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == "ok") {

        } else {
          Fluttertoast.showToast(msg: "Invalid");
        }
      }

    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  String unm = "";
  String psw = "";
  void setLogin() async{
    SharedPreferences sh = await SharedPreferences.getInstance();
    unm =sh.getString("unm").toString();
    psw = sh.getString("psw").toString();

    unamecontroller.text = unm;
    passcontroller.text = psw;

  }

  bool isValidGmail(String input) {
    // Check if the input follows the pattern of a Gmail address
    // You can customize this validation according to your needs
    final RegExp gmailRegExp = RegExp(
      r'^[a-zA-Z0-9.]+@gmail\.com$',
      caseSensitive: false,
      multiLine: false,
    );
    return gmailRegExp.hasMatch(input);
  }
}

