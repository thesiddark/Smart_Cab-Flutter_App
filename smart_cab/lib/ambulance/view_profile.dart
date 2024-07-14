import 'dart:io';


import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart ';
import 'package:google_fonts/google_fonts.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:smart_cab/ambulance/ahome.dart';
import 'package:smart_cab/ambulance/edit_profile.dart';
import 'package:smart_cab/driver/edit_profile.dart';
import 'package:smart_cab/driver/home.dart';

void main() {
  runApp(const ptemp());
}

class ptemp extends StatelessWidget {
  const ptemp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Ambulance_Profile(title: 'Home'),
    );
  }
}

class Ambulance_Profile extends StatefulWidget {
  const Ambulance_Profile({super.key, required this.title});

  final String title;

  @override
  State<Ambulance_Profile> createState() => _Ambulance_ProfileState();
}







class _Ambulance_ProfileState extends State<Ambulance_Profile> {

  String name_ = "";
  String dob_ = "";
  String gender_ = "";
  String phone_ = "";
  String email_ = "";
  String photo_ = "";
  // String vphoto_ = "";
  String proof_ = "";
  String place_ = "";
  String post_ = "";
  String pin_ = "";
  String district_ = "";
  String vnumber_ = "";



  void senddata() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();

    final urls = Uri.parse('$url/ambulance_view_profile/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        print(jsonDecode(response.body));

        if (status == "ok") {
          String name = jsonDecode(response.body)['name'];
          String gender = jsonDecode(response.body)['gender'];
          String phone = jsonDecode(response.body)['phone'];
          String email = jsonDecode(response.body)['email'];
          String dob = jsonDecode(response.body)['dob'].toString();
          String photo = sh.getString("imageurl").toString() +
              jsonDecode(response.body)['photo'];
          String proof = sh.getString("imageurl").toString() +
              jsonDecode(response.body)['proof'];
          // String vphoto = sh.getString("imageurl").toString() +
          //     jsonDecode(response.body)['vphoto'];
          String place = jsonDecode(response.body)['place'];
          String post = jsonDecode(response.body)['post'];
          String pin = jsonDecode(response.body)['pin'];
          String district = jsonDecode(response.body)['district'];
          String vnumber = jsonDecode(response.body)['vnumber'];
          // String statuss = jsonDecode(response.body)['status'];
          // Fluttertoast.showToast(msg: photo);

          setState(() {
            name_ = name;
            dob_ = dob;
            gender_ = gender;
            phone_ = phone;
            email_ = email;
            photo_ = photo;
            // Fluttertoast.showToast(msg: photo_);
            // vphoto_ = vphoto;
            proof_ = proof;
            place_ = place;
            post_ = post;
            pin_ = pin;
            district_ = district;
            // statuss_ = statuss;
            vnumber_ = vnumber;
          });
        } else {
          Fluttertoast.showToast(msg: "Not Found");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }



  _Ambulance_ProfileState() {
    senddata();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AmbulanceHome(title: ""),
            ));
        return false;
      },

      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leadingWidth: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PROFILE',
                style: GoogleFonts.poppins(
                  color: Colors.black12,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white54,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    maxRadius: 65,
                    backgroundImage: NetworkImage(photo_),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ambulance_Edit_Profile(title: ''),
                              ));
                        },
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 18,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name_,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                  )
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [Text(email_)],
              // ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: Expanded(
                    child: ListView(
                      children: [
                        Card(
                          margin: const EdgeInsets.only(
                              left: 35, right: 35, bottom: 10),
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => SearchBlood(
                              //           title: "",
                              //         )));
                            },
                            leading: Icon(
                              Icons.email,
                              color: Colors.black54,
                            ),
                            title: Text(
                              email_,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            // trailing: Icon(
                            //   Icons.arrow_forward_ios_outlined,
                            //   color: Colors.black54,
                            // ),
                          ),
                        ),

                        // Card(
                        //   margin: const EdgeInsets.only(
                        //       left: 35, right: 35, bottom: 10),
                        //   color: Colors.white70,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(30)),
                        //   child: ListTile(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => ProfileUiPage()));
                        //     },
                        //     leading: Icon(
                        //       Icons.privacy_tip_sharp,
                        //       color: Colors.black54,
                        //     ),
                        //     title: Text(
                        //       'View Profile',
                        //       style: TextStyle(
                        //           fontSize: 18, fontWeight: FontWeight.bold),
                        //     ),
                        //     trailing: Icon(
                        //       Icons.arrow_forward_ios_outlined,
                        //       color: Colors.black54,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          margin: const EdgeInsets.only(
                              left: 35, right: 35, bottom: 10),
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => SearchBlood(
                              //           title: "",
                              //         )));
                            },
                            leading: Icon(
                              Icons.calendar_month,
                              color: Colors.black54,
                            ),
                            title: Text(
                              dob_,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            // trailing: Icon(
                            //   // Icons.arrow_forward_ios_outlined,
                            //   // color: Colors.black54,
                            // ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          margin: const EdgeInsets.only(
                              left: 35, right: 35, bottom: 10),
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ExampleApp()));
                            },
                            leading: Icon(
                              Icons.transgender,
                              color: Colors.black54,
                            ),
                            title: Text(
                              gender_,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            // trailing: Icon(
                            //   Icons.arrow_forward_ios_outlined,
                            //   color: Colors.black54,
                            // ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white70,
                          margin: const EdgeInsets.only(
                              left: 35, right: 35, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => HealthProfile(
                              //           title: '',
                              //         )));
                            },
                            leading: Icon(
                              Icons.place,
                              color: Colors.black54,
                            ),
                            title: Text(
                              place_,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            // trailing: Icon(
                            //   Icons.arrow_forward_ios_outlined,
                            //   color: Colors.black54,
                            // ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white70,
                          margin: const EdgeInsets.only(
                              left: 35, right: 35, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ()));
                            },
                            leading: Icon(Icons.pin, color: Colors.black54),
                            title: Text(
                              pin_,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            // trailing: Icon(
                            //   Icons.arrow_forward_ios_outlined,
                            //   color: Colors.black54,
                            // ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white70,
                          margin: const EdgeInsets.only(
                              left: 35, right: 35, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             MyViewNotificationPage(title: "")));
                            },
                            leading: Icon(
                              Icons.place_sharp,
                              color: Colors.black54,
                            ),
                            title: Text(
                              district_,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            // trailing: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ),
                        // Card(
                        //   color: Colors.white70,
                        //   margin: const EdgeInsets.only(
                        //       left: 35, right: 35, bottom: 10),
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(30)),
                        //   child: ListTile(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   MyMyFeedbackViewPage(title: "")));
                        //     },
                        //     leading: Icon(
                        //       Icons.feedback,
                        //       color: Colors.black54,
                        //     ),
                        //     title: Text(
                        //       'Feedback',
                        //       style: TextStyle(
                        //           fontSize: 18, fontWeight: FontWeight.bold),
                        //     ),
                        //     trailing: Icon(Icons.arrow_forward_ios_outlined),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Card(
                        //   color: Colors.white70,
                        //   margin: const EdgeInsets.only(
                        //       left: 35, right: 35, bottom: 10),
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(30)),
                        //   child: ListTile(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => MyLogin()));
                        //     },
                        //     leading: Icon(
                        //       Icons.logout,
                        //       color: Colors.black54,
                        //     ),
                        //     title: Text(
                        //       'Logout',
                        //       style: TextStyle(
                        //           fontSize: 18, fontWeight: FontWeight.bold),
                        //     ),
                        //     trailing: Icon(Icons.arrow_forward_ios_outlined),
                        //   ),
                        // )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }


// String statuss_ = "";


}
