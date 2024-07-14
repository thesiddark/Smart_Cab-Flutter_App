
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cab/user/home.dart';
import 'package:smart_cab/user/send_complaint.dart';

void main() {
  runApp(const ViewReply());
}

class ViewReply extends StatelessWidget {
  const ViewReply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(
        // colorScheme:
        //     ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 224, 224, 157)),
        // useMaterial3: true,
      ),
      home: const ViewAmbulancePayment(title: ''),
    );
  }
}

class ViewAmbulancePayment extends StatefulWidget {
  const ViewAmbulancePayment({super.key, required this.title});

  final String title;

  @override
  State<ViewAmbulancePayment> createState() => _ViewAmbulancePaymentState();
}

class _ViewAmbulancePaymentState extends State<ViewAmbulancePayment> {
  _ViewAmbulancePaymentState() {
    viewreply();
  }

  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> amount_ = <String>[];
  List<String> source_ = <String>[];
  List<String> destination_ = <String>[];
  List<String> vehicle_ = <String>[];

  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> amount = <String>[];
    List<String> source = <String>[];
    List<String> destination = <String>[];
    List<String> vehicle = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_ambu_payment/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        amount.add(arr[i]['amount'].toString());
        source.add(arr[i]['source']);
        destination.add(arr[i]['destination']);
        vehicle.add(arr[i]['vehicle'].toString());
      }

      setState(() {
        id_ = id;
        date_ = date;
        amount_ = amount;
        source_ = source;
        destination_ = destination;
        vehicle_ = vehicle;
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
                child: Card(
                  elevation: 8,
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                // Add your date text style here
                              ),
                            ),
                            // Wrap the complaint text in an ExpansionTile
                            // Expanded(
                            //   child: ExpansionTile(
                            //     title: Text(
                            //       complaint_[index],
                            //       maxLines: 1,
                            //       // Set the number of lines to show initially
                            //       overflow: TextOverflow.ellipsis,
                            //       style: TextStyle(
                            //         // Add your complaint text style here
                            //       ),
                            //     ),
                            //     children: <Widget>[
                            //       Text(
                            //         maxLines: 2,
                            //         // Set the number of lines to show initially
                            //         overflow: TextOverflow.ellipsis,
                            //         complaint_[index],
                            //         style: TextStyle(
                            //           // Add your expanded complaint text style here
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                        // SizedBox(height: 2),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Destination: ",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     SizedBox(height: 2),
                        //     Text(
                        //       reply_[index],
                        //       style: TextStyle(
                        //         // Add your reply text style here
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
                              "Vehicle no: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              vehicle_[index],
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
                              "Amount: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              amount_[index],
                              style: TextStyle(
                                // Add your status text style here
                              ),
                            ),
                          ],
                        ),


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
