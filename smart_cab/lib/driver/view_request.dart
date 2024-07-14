
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cab/driver/home.dart';
import 'package:smart_cab/user/home.dart';
import 'package:smart_cab/user/send_driver_request.dart';
import 'package:smart_cab/user/view_more_driver.dart';
import 'package:smart_cab/user/view_request_status_more.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'View Reply',
      // theme: ThemeData(
        // colorScheme:
        //     ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 224, 224, 157)),
        // useMaterial3: true,
      // ),
      home: const UserRequestStatus(title: ''),
    );
  }
}

class UserRequestStatus extends StatefulWidget {
  const UserRequestStatus({super.key, required this.title});

  final String title;

  @override
  State<UserRequestStatus> createState() => _UserRequestStatusState();
}

class _UserRequestStatusState extends State<UserRequestStatus> {
  _UserRequestStatusState() {
    viewmanager();
  }

  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> source_ = <String>[];
  List<String> destination_ = <String>[];
  List<String> uname_ = <String>[];
  List<String> uphone_ = <String>[];
  List<String> uemail_ = <String>[];
  // List<String> district_ = <String>[];

  Future<void> viewmanager() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> source = <String>[];
    List<String> destination = <String>[];
    List<String> uname = <String>[];
    List<String> uphone = <String>[];
    List<String> uemail = <String>[];

    // List<String> district = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/driver_view_request/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];



      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['datee'].toString());
        source.add(arr[i]['source'].toString());
        destination.add(arr[i]['destination'].toString());
        uname.add(arr[i]['uname'].toString());
        uphone.add(arr[i]['uphone'].toString());
        uemail.add(arr[i]['uemail'].toString());

      }

      setState(() {
        id_ = id;
        date_ = date;
        source_ = source;
        destination_ = destination;
        uname_ = uname;
        uphone_ = uphone;
        uemail_=uemail;
      });


    } catch (e) {
      // print(statuss);
      Fluttertoast.showToast(msg: e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DriverHome(
                title: "",
              ),
            ));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DriverHome(title: '')),
              );
            },
          ),
          backgroundColor: Color.fromARGB(255, 232, 177, 61),
          title: Text(widget.title),
        ),
        body:
          a()
        // ListView.builder(
        //   physics: BouncingScrollPhysics(),
        //   // padding: EdgeInsets.all(5.0),
        //   // shrinkWrap: true,
        //   itemCount: id_.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return ListTile(
        //       onLongPress: () {
        //         print("long press" + index.toString());
        //       },
        //       title: Padding(
        //         padding: const EdgeInsets.all(9),
        //         child: Card(
        //           elevation: 8,
        //           margin: EdgeInsets.all(10),
        //           child: Padding(
        //             padding: const EdgeInsets.all(12),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Row(
        //                   children: [
        //                     Text(
        //                       "Date: ",
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                       ),
        //                     ),
        //                     SizedBox(height: 2),
        //                     Text(
        //                       date_[index],
        //                       style: TextStyle(
        //                           // Add your date text style here
        //                           ),
        //                     ),
        //                   ],
        //                 ),
        //                 SizedBox(height: 8),
        //                 Row(
        //                   children: [
        //                     Text(
        //                       "Complaint: ",
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                       ),
        //                     ),
        //                     SizedBox(height: 2),
        //                     Text(
        //                       complaint_[index],
        //                       style: TextStyle(
        //                           // Add your complaint text style here
        //                           ),
        //                     ),
        //                   ],
        //                 ),

        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
        // ListView.builder(
        //   physics: BouncingScrollPhysics(),
        //   // padding: EdgeInsets.all(5.0),
        //   // shrinkWrap: true,
        //   itemCount: id_.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return ListTile(
        //       onLongPress: () {
        //         print("long press" + index.toString());
        //       },
        //       title: Padding(
        //           padding: const EdgeInsets.all(9),
        //           child: Column(
        //             children: [
        //               Card(
        //                 child: Row(children: [
        //                   Column(
        //                     children: [
        //                       Padding(
        //                         padding: EdgeInsets.all(9),
        //                         child: Row(
        //                           children: [
        //                             Text("Date :"),
        //                             SizedBox(
        //                               height: 2,
        //                             ),
        //                             Text(date_[index]),
        //                           ],
        //                         ),
        //                       ),
        //                       Padding(
        //                           padding: EdgeInsets.all(9),
        //                           child: Row(
        //                             children: [
        //                               Text("Complaint :"),
        //                               SizedBox(
        //                                 height: 2,
        //                               ),
        //                               Text(complaint_[index]),
        //                             ],
        //                           )),
        //                       Padding(
        //                           padding: EdgeInsets.all(9),
        //                           child: Row(
        //                             children: [
        //                               Text("Reply :"),
        //                               SizedBox(
        //                                 height: 2,
        //                               ),
        //                               Text(reply_[index]),
        //                             ],
        //                           )),
        //                       Padding(
        //                           padding: EdgeInsets.all(9),
        //                           child: Row(
        //                             children: [
        //                               Text("Status :"),
        //                               SizedBox(
        //                                 height: 2,
        //                               ),
        //                               Text(status_[index]),
        //                             ],
        //                           )),
        //                     ],
        //                   ),
        //                 ]),
        //                 elevation: 8,
        //                 margin: EdgeInsets.all(10),
        //               ),
        //             ],
        //           )),
        //     );
        //   },
        // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => MyComplaint(title: 'Complaint')));
        //   },
        //   child: Icon(Icons.edit_note_rounded),
        // ),
      ),
    );
  }
  a(){
    if (id_.length == 0) {
      return Center(child:Text("No data Yet.."),);
    }
    else{
      return ListView.builder(
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
              child: Card(
                elevation: 8,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     CircleAvatar(
                      //       maxRadius: 65,
                      //       backgroundImage: NetworkImage(vphoto_[index]),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            "Date: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            date_[index],
                            style: TextStyle(
                              // Add your date text style here
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Image(
                      //       image: NetworkImage(photo_[index]),
                      //       fit: BoxFit.cover,
                      //     ),
                      //
                      //
                      // ]),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Qalification: ",
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     SizedBox(height: 2),
                      //     Text(
                      //       qualification_[index],
                      //       style: TextStyle(
                      //         // Add your date text style here
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Info: ",
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     SizedBox(height: 2),
                      //     // Wrap the complaint text in an ExpansionTile
                      //     Expanded(
                      //       child: ExpansionTile(
                      //         title: Text(
                      //           place_[index],
                      //           maxLines: 1,
                      //           // Set the number of lines to show initially
                      //           overflow: TextOverflow.ellipsis,
                      //           style: TextStyle(
                      //               // Add your complaint text style here
                      //               ),
                      //         ),
                      //         children: <Widget>[
                      //           Text(
                      //             maxLines: 2,
                      //             // Set the number of lines to show initially
                      //             overflow: TextOverflow.ellipsis,
                      //             complaint_[index],
                      //             style: TextStyle(
                      //                 // Add your expanded complaint text style here
                      //                 ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            "Source: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            source_[index],
                            style: TextStyle(
                              // Add your reply text style here
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            "Destination: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            destination_[index],
                            style: TextStyle(
                              // Add your status text style here
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            "User name: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            uname_[index],
                            style: TextStyle(
                              // Add your status text style here
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),

                      Row(
                        children: [
                          Text(
                            "Email: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            uemail_[index],
                            style: TextStyle(
                              // Add your status text style here
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),

                      Row(
                        children: [
                          Text(
                            "Phone: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            uphone_[index],
                            style: TextStyle(
                              // Add your status text style here
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                        width: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 5,),ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.blue),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.black87),
                              ),
                              onPressed: () async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String rid = id_[index];
    String url = sh.getString('url').toString();
    final urls = Uri.parse('$url/driver_approve_request/');
    try {
    final response = await http.post(urls, body: {'rid': rid});
    if (response.statusCode == 200) {
    String status = jsonDecode(response.body)['status'];
    if (status == 'ok') {
    Fluttertoast.showToast(msg: 'Approved Successfully');
    Navigator.push(context, MaterialPageRoute(builder: (context) => DriverHome(title: "")));
    } else {
    Fluttertoast.showToast(msg: 'Not Found');
    }
    } else {
    Fluttertoast.showToast(msg: 'Network Error');
    }
    } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
    }
    },
                              child: Text("Accept")),

                          SizedBox(
                            height: 10,
                            width: 20,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.red),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.black87),
                              ),
                              onPressed: () async {
                                SharedPreferences sh = await SharedPreferences.getInstance();
                                String rid = id_[index];
                                String url = sh.getString('url').toString();
                                final urls = Uri.parse('$url/driver_reject_request/');
                                try {
                                  final response = await http.post(urls, body: {'rid': rid});
                                  if (response.statusCode == 200) {
                                    String status = jsonDecode(response.body)['status'];
                                    if (status == 'ok') {
                                      Fluttertoast.showToast(msg: 'Rejected Successfully');
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DriverHome(title: "")));
                                    } else {
                                      Fluttertoast.showToast(msg: 'Not Found');
                                    }
                                  } else {
                                    Fluttertoast.showToast(msg: 'Network Error');
                                  }
                                } catch (e) {
                                  Fluttertoast.showToast(msg: e.toString());
                                }
                              },
                              child: Text("Reject"))
                        ],
                      ),

                      // Row(children: [
                      //   ElevatedButton(onPressed: {
                      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>NewHomePage(title: ""),));
                      //   },
                      //       child: Text("Chat"))],),

                      // ... (other rows for Reply, Status, etc.)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );

  }
  }
}
