import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cab/login.dart';
import 'package:smart_cab/newlogintemp.dart';

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
      home: const MyIpPage(
          title: ''),
    );
  }
}

class MyIpPage extends StatefulWidget {
  const MyIpPage({super.key, required this.title});


  final String title;

  @override
  State<MyIpPage> createState() => _MyIpPageState();
}

class _MyIpPageState extends State<MyIpPage> {
  int _counter = 0;
  TextEditingController ipController = new TextEditingController();
  var _formKey = GlobalKey<FormState>();


  _MyIpPageState()
  {
    ipController.text="192.168.29.121";
  }

  // void _incrementCounter() {
  //   setState(() {
  //
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //
      //   title: Text(widget.title),
      // ),
      body:
      Form(
        key: _formKey,
        child: Container(
          height: 750,
          width: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/ip.jpg'), fit: BoxFit.cover),
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
                  labelText: 'Enter IPAddress',
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required.Please enter a valid ip address';
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
                      String ip = ipController.text.toString();
                      print(ip);
                      SharedPreferences sh =
                      await SharedPreferences.getInstance();
                      sh.setString("url", "http://" + ip + ":8000/myapp");
                      sh.setString("imageurl", "http://" + ip + ":8000");

                      // Route
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(
                              title: "",
                            ),
                          ));
                    } else {
                      return null;
                    }
                  },
                  child: Text('Connect')),

            ],
          ),
        ),
      )

    );
  }
}
