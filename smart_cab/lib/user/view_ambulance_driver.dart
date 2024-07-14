
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cab/user/home.dart';
import 'package:smart_cab/user/send_ambulance_request.dart';
import 'package:smart_cab/user/send_driver_request.dart';
import 'package:smart_cab/user/view_more_ambulance.dart';
import 'package:smart_cab/user/view_more_driver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'View Reply',
      theme: ThemeData(
        // colorScheme:
        //     ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 224, 224, 157)),
        // useMaterial3: true,
      ),
      home: const UserViewAmbulance(title: ''),
    );
  }
}

class UserViewAmbulance extends StatefulWidget {
  const UserViewAmbulance({super.key, required this.title});

  final String title;

  @override
  State<UserViewAmbulance> createState() => _UserViewAmbulanceState();
}

class _UserViewAmbulanceState extends State<UserViewAmbulance> {
  _UserViewAmbulanceState() {
    viewmanager();
  }

  List<String> id_ = <String>[];
  List<String> name_ = <String>[];
  List<String> vnumber_ = <String>[];
  List<String> phone_ = <String>[];
  List<String> place_ = <String>[];
  List<String> photo_ = <String>[];


  Future<void> viewmanager() async {
    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> vnumber = <String>[];
    List<String> phone = <String>[];
    List<String> place = <String>[];
    List<String> photo = <String>[];

    // List<String> district = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_ambulance/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());

        name.add(arr[i]['dname']);

        phone.add(arr[i]['phone'].toString());
        vnumber.add(arr[i]['vnumber'].toString());

        photo.add(sh.getString("imageurl").toString() + arr[i]['vphoto']);
        place.add(arr[i]['place'].toString());

      }

      setState(() {
        id_ = id;
        name_ = name;
        phone_ = phone;
        vnumber_ = vnumber;
        photo_ = photo;
        place_ = place;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
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
              builder: (context) => UserHome(
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
                MaterialPageRoute(builder: (context) => UserHome(title: '')),
              );
            },
          ),
          backgroundColor: Color.fromARGB(255, 232, 177, 61),
          title: Text(widget.title),
        ),
        body:
        ListView.builder(
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
                  elevation: 10,
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              maxRadius: 30,
                              backgroundImage: NetworkImage(photo_[index]),
                            ),
                            Text(
                              "Name:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 1,),
                            Text(
                              name_[index],
                              style: TextStyle(
                                // Add your date text style here
                              ),
                            ),



                          ],
                        ),
                        // SizedBox(height: 2),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Name: ",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     SizedBox(height: 2),
                        //     Text(
                        //       name_[index],
                        //       style: TextStyle(
                        //         // Add your date text style here
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
                              "Vehicle Number: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              vnumber_[index],
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
                              "Phone: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              phone_[index],
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
                              "Place: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              place_[index],
                              style: TextStyle(
                                // Add your status text style here
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),

                        // Row(
                        //   children: [
                        //     Text(
                        //       "District: ",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     SizedBox(height: 2),
                        //     Text(
                        //       district_[index],
                        //       style: TextStyle(
                        //         // Add your status text style here
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 20,
                          width: 5,
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
                                  SharedPreferences sh =
                                  await SharedPreferences.getInstance();
                                  sh.setString("did", id_[index]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserViewAmbulancemore(title: ""),
                                      ));
                                },
                                child: Text("More")),

                            SizedBox(
                              height: 10,
                              width: 30,
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
                                  SharedPreferences sh =
                                  await SharedPreferences.getInstance();
                                  sh.setString("did", id_[index]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserSendAmbulanceRequest(title: ""),
                                      ));
                                },
                                child: Text("Request"))
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
        ),
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
}
