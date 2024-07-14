import 'dart:convert';

// import 'package:aidietitian/home.dart';
// import 'package:aidietitian/main.dart';
// import 'package:aidietitian/signUp.dart';
// import 'package:aidietitian/view%20reply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_cab/user/home.dart';

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
      home: const Sendfeedback(title: 'Send Complaint'),
    );
  }
}

class Sendfeedback extends StatefulWidget {
  const Sendfeedback({super.key, required this.title});

  final String title;

  @override
  State<Sendfeedback> createState() => _SendfeedbackState();
}

class _SendfeedbackState extends State<Sendfeedback> {
  int _counter = 0;

  TextEditingController feedController = new TextEditingController();

  var _formKey = GlobalKey<FormState>();


  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserHome(title: "Home")),
            );
          },
        ),
        backgroundColor: Color.fromARGB(255, 232, 177, 61),
        title: Text(widget.title),
      ),
      // Here we take the value from the Sendfeedback object that was created by
      // the App.build method, and use it to set our appbar title.
      // title: Align(
      //   child: Text(widget.title, textAlign: TextAlign.center),
      //   alignment: Alignment.center,
      // ),
      // ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10),child:
              // Row(  children: [
              TextFormField(
                maxLines: 5,
                controller: feedController,
                decoration: InputDecoration(
                  labelText: 'Type here....',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),

                // ],
                // ),
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

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    senddata();
                  }
                  else {
                    return null;
                  }
                },
                child: Text("Send"),
              ),
            ],
          ),

        ),


      ),
    );
  }

  void senddata()async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_feedback_post/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'review': feedController.text,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(
              msg: 'Feedback Send Sussessfully');

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
