import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cab/login.dart';
import 'package:smart_cab/user/home.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(

        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: const UserSendAmbulanceRequest(
          title: ''),
    );
  }
}

class UserSendAmbulanceRequest extends StatefulWidget {
  const UserSendAmbulanceRequest({super.key, required this.title});


  final String title;

  @override
  State<UserSendAmbulanceRequest> createState() => _UserSendAmbulanceRequestState();
}

class _UserSendAmbulanceRequestState extends State<UserSendAmbulanceRequest> {
  int _counter = 0;
  TextEditingController ipController = new TextEditingController();
  TextEditingController spController = new TextEditingController();
  var _formKey = GlobalKey<FormState>();

  // void _incrementCounter() {
  //   setState(() {
  //
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          backgroundColor: Color.fromARGB(255, 232, 177, 61),

          title: Text(widget.title),
        ),
        body:
        Form(
          key: _formKey,
          child: Container(
            height: 750,
            width: 500,
            decoration: const BoxDecoration(
              // image: DecorationImage(
              //     // image: AssetImage('assets/ip.jpg'),
              //     fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: ipController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Source',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: spController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Destination',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),


                SizedBox(
                  height: 4,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String ipp = ipController.text.toString();
                        String dp = spController.text.toString();
                        // print(ip);
                        SharedPreferences sh =
                        await SharedPreferences.getInstance();
                        // sh.setString("url", "http://" + ip + ":8000/myapp");
                        // sh.setString("imageurl", "http://" + ip + ":8000");
                        String url = sh.getString('url').toString();
                        String lid = sh.getString('lid').toString();
                        String did = sh.getString('did').toString();

                        final urls = Uri.parse('$url/user_send_ambulance_request/');
                        try {
                          final response = await http.post(urls, body: {

                            'lid': lid,
                            'did': did,
                            'source':ipp,
                            'destination':dp
                            // 'type': intrest,
                          });
                          if (response.statusCode == 200) {
                            String status = jsonDecode(response.body)['status'];
                            if (status == 'ok') {
                              Fluttertoast.showToast(msg: 'Requested Successfully');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserHome(title: ""),
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

                        // Route

                      } else {
                        return null;
                      }
                    },
                    child: Text('SEND')),

              ],
            ),
          ),
        )

    );
  }
}
