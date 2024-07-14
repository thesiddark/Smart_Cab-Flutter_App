// import 'package:aidietitian/main.dart';
// import 'package:aidietitian/signUp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smart_cab/user/sendfeedback.dart';

void main() {
  runApp(const ViewFeedback(title: "View reply"));
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
      home: const ViewFeedback(title: 'IPAddress'),
    );
  }
}

class ViewFeedback extends StatefulWidget {
  const ViewFeedback({super.key, required this.title});

  final String title;

  @override
  State<ViewFeedback> createState() => _ViewFeedbackState();
}

class _ViewFeedbackState extends State<ViewFeedback> {
  _ViewFeedbackState() {
    ViewFeedback();
  }

  List<String> id_= <String>[];
  List<String> date_= <String>[];
  List<String> feedback_= <String>[];


  Future<void> ViewFeedback() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> feedback = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_feedback_post/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        feedback.add(arr[i]['feedback']);

      }

      setState(() {
        id_ = id;
        date_ = date;

        feedback_ = feedback;
        // status_ = status;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
    // int _counter = 0;

    // TextEditingController ipController = new TextEditingController();

    // void _incrementCounter() {
    //   setState(() {
    //     _counter++;
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the ViewFeedback object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Align(
          child: Text(widget.title, textAlign: TextAlign.center),
          alignment: Alignment.center,
        ),
        backgroundColor: Color.fromARGB(255, 232, 177, 61),

      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        // padding: EdgeInsets.all(5.0),
        // shrinkWrap: true,
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onLongPress: () {
              print("long press" + index.toString());
            },
            title: Padding(
                padding: const EdgeInsets.all(9),
                child: Column(
                  children: [
                    Card(child: Row(
                      children: [Column
                        (children: [SizedBox(height: 3, width: 100,),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(children: [Text("         Date:"),
                            SizedBox(height: 4,
                              width: 60,),Text(date_[index])],),),
                        Padding(padding: EdgeInsets.all(10),
                          child:
                          Row(children: [Text("  Feedback:"),
                            SizedBox(height: 4,
                              width: 40,),
                            Text(feedback_[index])],),),
                        // Padding(padding: EdgeInsets.all(10),
                        //   child:
                        //   Row(children: [Text("Reply:"),
                        //     SizedBox(height: 4,
                        //       width: 60,),
                        //     Text(reply_[index])],),),
                        // Padding(padding: EdgeInsets.all(10),
                        //   child:
                        //   Row(children: [Text("Status:"),
                        //     SizedBox(height: 4,
                        //       width: 60,),
                        //     Text(status_[index])],),),
                      ],)],),),
                  ],
                )),

            // title: Padding(
            //     padding: const EdgeInsets.all(9),
            //     child: Column(
            //       children: [
            //         Card(child: Row(
            //           children: [Column
            //             (children: [
            //               SizedBox(height: 3, width: 100,),
            //             Padding(
            //               padding: EdgeInsets.all(10),
            //               child: Row(children: [Text("         Date:"),
            //                 SizedBox(height: 4,
            //                   width: 60,),Text(date_[index])],),),
            //             SizedBox(height: 3, width: 100,),
            //
            //             Padding(padding: EdgeInsets.all(10),
            //               child:
            //               Row(children:[
            //               Text("    Feedback:"),
            //                 SizedBox(height: 3,
            //                   width: 40,),
            //                 Text(feedback_[index])],),),
            //             // Padding(padding: EdgeInsets.all(10),
            //             //   child:
            //             //   Row(children: [Text("Reply:"),
            //             //     SizedBox(height: 4,
            //             //       width: 60,),
            //             //     Text(reply_[index])],),),
            //             // Padding(padding: EdgeInsets.all(10),
            //             //   child:
            //             //   Row(children: [Text("Status:"),
            //             //     SizedBox(height: 4,
            //             //       width: 60,),
            //             //     Text(status_[index])],),),
            //           ],)],),),
            //       ],
            //     )),
          );
        },
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Sendfeedback(title: 'Feedback')));
        },
        child: Icon(Icons.feedback),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
