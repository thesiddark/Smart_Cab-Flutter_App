
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cab/user/ambu_payment.dart';
import 'package:smart_cab/user/home.dart';
import 'package:smart_cab/user/send_driver_request.dart';
import 'package:smart_cab/user/view_ambulance_request_more.dart';
import 'package:smart_cab/user/view_more_driver.dart';
import 'package:smart_cab/user/view_request_status_more.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';



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
      home: const UserViewAmbulanceStatus(title: ''),
    );
  }
}

class UserViewAmbulanceStatus extends StatefulWidget {
  const UserViewAmbulanceStatus({super.key, required this.title});

  final String title;

  @override
  State<UserViewAmbulanceStatus> createState() => _UserViewAmbulanceStatusState();
}

class _UserViewAmbulanceStatusState extends State<UserViewAmbulanceStatus> {
  _UserViewAmbulanceStatusState() {
    viewmanager();
  }

  List<String> id_ = <String>[];
  List<String> aid_ = <String>[];
  List<String> date_ = <String>[];
  List<String> number_ = <String>[];
  List<String> vphoto_ = <String>[];
  List<String> statuss_ = <String>[];
  List<String> source_ = <String>[];
  List<String> destination_ = <String>[];
  List<String> paid_ = <String>[];
  List<String> selfno_ = <String>[];
  List<String> driverno_ = <String>[];
  // List<String> district_ = <String>[];

  Future<void> viewmanager() async {
    List<String> id = <String>[];
    List<String> aid = <String>[];
    List<String> date = <String>[];
    List<String> number = <String>[];
    List<String> vphoto = <String>[];
    List<String> status = <String>[];
    List<String> source = <String>[];
    List<String> destination = <String>[];
    List<String> paid = <String>[];
    List<String> selfno = <String>[];
    List<String> driverno = <String>[];
    // List<String> district = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_ambulance_status/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        aid.add(arr[i]['aid'].toString());
        date.add(arr[i]['date']);
        number.add(arr[i]['number'].toString());
        vphoto.add(sh.getString("imageurl").toString() + arr[i]['vphoto']);
        status.add(arr[i]['statuss']);
        source.add(arr[i]['source']);
        destination.add(arr[i]['destination']);
        paid.add(arr[i]['paid']);
        selfno.add(arr[i]['selfno']);
        driverno.add(arr[i]['driverno']);

      }

      setState(() {
        id_ = id;
        aid_ = aid;
        date_ = date;
        number_ = number;
        vphoto_ = vphoto;
        statuss_ = status;
        source_ = source;
        destination_=destination;
        paid_=paid;
        driverno_=driverno;
        selfno_=selfno;
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
                  elevation: 8,
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
                              maxRadius: 65,
                              backgroundImage: NetworkImage(vphoto_[index]),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              "Number: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              number_[index],
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
                              "Status: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              statuss_[index],
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
                          width: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5,),
                            Visibility(
                              visible: statuss_[index] == "approved",
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                ),
                                onPressed: ()async{
    if (paid_[index]!='yes') {
      SharedPreferences sh = await SharedPreferences.getInstance();
      sh.setString("aid", id_[index].toString());
      // String rid = id_[index].toString();
      String url = sh.getString('url').toString();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AmbulancePayment(),));
      _sendSMS([selfno_[index],driverno_[index]]);
    }

                                },
                                child:paid_[index]=='yes'?Text('paid'): Text("Payment"),
                              ),
                            ),



                            SizedBox(
                              height: 10,
                              width: 5,
                            ),
                            Visibility(
                              visible: statuss_[index] == "approved",
                              child: IconButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                ),
                                onPressed: () async {
                                  SharedPreferences sh = await SharedPreferences
                                      .getInstance();
                                  String mid = aid_[index].toString();
                                  String url = sh.getString('url').toString();
                                  final urls = Uri.parse(
                                      '$url/user_get_ambulance_location/');
                                  try {
                                    final response = await http.post(
                                        urls, body: {'id': mid});
                                    if (response.statusCode == 200) {
                                      String status = jsonDecode(
                                          response.body)['status'];
                                      if (status == 'ok') {
                                        String lat = jsonDecode(
                                            response.body)['lati'];
                                        String long = jsonDecode(
                                            response.body)['longi'];
                                        _launchUrl(lat, long);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'Not Found');
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Network Error');
                                    }
                                  } catch (e) {
                                    Fluttertoast.showToast(msg: e.toString());
                                  }
                                  // SharedPreferences sh = await SharedPreferences.getInstance();
                                  // String mid = mid_;
                                  // String url = sh.getString('url').toString();
                                  // final urls = Uri.parse('$url/confirm_document/');
                                  // try {
                                  //   final response = await http.post(urls, body: {'id': mid});
                                  //   if (response.statusCode == 200) {
                                  //     String status = jsonDecode(response.body)['status'];
                                  //     if (status == 'ok') {
                                  //       Fluttertoast.showToast(msg: 'Confirmed Successfully');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserHome(title: ''),
                                    ),
                                  );
                                  //     } else {
                                  //       Fluttertoast.showToast(msg: 'Not Found');
                                  //     }
                                  //   } else {
                                  //     Fluttertoast.showToast(msg: 'Network Error');
                                  //   }
                                  // } catch (e) {
                                  //   Fluttertoast.showToast(msg: e.toString());
                                  // }
                                },
                                icon: Icon(Icons.pin_drop),
                              ),
                            ),
                            SizedBox(width: 2,),
                            IconButton(
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
                                            UserViewAmbulanceStatusMore(title: ""),
                                      ));
                                },
                                icon: Icon(Icons.more_horiz)),


                            // ElevatedButton(
                            //     style: ButtonStyle(
                            //       backgroundColor:
                            //       MaterialStateProperty.all<Color>(
                            //           Colors.red),
                            //       foregroundColor:
                            //       MaterialStateProperty.all<Color>(
                            //           Colors.black87),
                            //     ),
                            //     onPressed: () async {
                            //       SharedPreferences sh =
                            //       await SharedPreferences.getInstance();
                            //       sh.setString("did", id_[index]);
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) =>
                            //                 UserSendDiverRequest(title: ""),
                            //           ));
                            //     },
                            //     child: Text("Request"))
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
  Future<void> _launchUrl(l, k) async {
    String url = "https://maps.google.com/?q=" + l + ',' + k;
    // String url="https://maps.google.com/q=?"+l+','+k;
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }

  }
  void _sendSMS(List<String> recipents) async {
    Random random = Random();
    int i = random.nextInt(99999999);
    SharedPreferences sh =
    await SharedPreferences.getInstance();
    sh.setString("vcode", i.toString());
    String _result = await sendSMS(message: '$i', recipients: recipents, sendDirect: true)
        .catchError((onError) {
      // print(onError);
    });
    // print('$i');
    // print(_result);
  }
}
