import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_cab/driver/change_password.dart';
import 'package:smart_cab/driver/user_payment_view.dart';
import 'package:smart_cab/driver/view_approved_request.dart';
import 'package:smart_cab/driver/view_profile.dart';
import 'package:smart_cab/driver/view_rejected_request.dart';
import 'package:smart_cab/driver/view_request.dart';
import 'package:smart_cab/login.dart';
import 'package:smart_cab/newlogintemp.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DriverHome(title: ''),
    );
  }
}

class DriverHome extends StatefulWidget {
  const DriverHome({super.key, required this.title});



  final String title;

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  TextEditingController ipcontroller=new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop:() async{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(title: "",),));
      return false;

    },


        child: Scaffold(
          appBar: AppBar(
            actions: [IconButton(
              color: Colors.white,
              icon: const Icon(Icons.logout),

              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LoginScreen(title: "",),));
              },
            ),],
            backgroundColor: Color.fromARGB(255, 232, 177, 61),

            title: Text(widget.title),
          ),
          body:
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/cat.jpg'), fit: BoxFit.cover),),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 210,
                childAspectRatio: 10/10,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,

              ),
              padding: const EdgeInsets.all(9.0),
              children: [

                Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:  Color.fromARGB(255,27, 77, 104),


                        borderRadius: BorderRadius.circular(15)),
                    child:  Column(
                        children: [
                          SizedBox(height: 5.0),
                          InkWell(

                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage:AssetImage('assets/ip.jpg')
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Driver_Profile(title: ""),));
                              },
                          ),
                          SizedBox(height: 10.0),
                          // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(2),
                                child: Text("Profile",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                                )),
                              ),],
                          ),


                        ]
                    )
                ),


                Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:  Color.fromARGB(255,27, 77, 104),


                        borderRadius: BorderRadius.circular(15)),
                    child:  Column(
                        children: [
                          SizedBox(height: 5.0),
                          InkWell(

                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage:AssetImage('assets/ip.jpg')
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) => UserRequestStatus(title:""),));
                              },
                          ),
                          SizedBox(height: 10.0),
                          // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(1),
                                child: Text("Request",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                                )),
                              ),],
                          ),


                        ]
                    )
                ),
                Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:  Color.fromARGB(255,27, 77, 104),


                        borderRadius: BorderRadius.circular(15)),
                    child:  Column(
                        children: [
                          SizedBox(height: 5.0),
                          InkWell(

                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage:AssetImage('assets/ip.jpg')
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) => UserApprovedStatus(title:""),));
                            },
                          ),
                          SizedBox(height: 10.0),
                          // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(1),
                                child: Text("Approved Request",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                                )),
                              ),],
                          ),


                        ]
                    )
                ),
                Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:  Color.fromARGB(255,27, 77, 104),


                        borderRadius: BorderRadius.circular(15)),
                    child:  Column(
                        children: [
                          SizedBox(height: 5.0),
                          InkWell(

                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage:AssetImage('assets/ip.jpg')
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => UserRejectedStatus(title:""),));
                            },
                          ),
                          SizedBox(height: 10.0),
                          // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(1),
                                child: Text("Rejected Request",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                                )),
                              ),],
                          ),


                        ]
                    )
                ),

                Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:  Color.fromARGB(255,27, 77, 104),


                        borderRadius: BorderRadius.circular(15)),
                    child:  Column(
                        children: [
                          SizedBox(height: 5.0),
                          InkWell(

                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage('assets/ip.jpg')
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DriverViewUserPayment(title:""),));
                            },
                          ),
                          SizedBox(height: 10.0),
                          // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(1),
                                child: Text("Payment",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                                )),
                              ),],
                          ),


                        ]
                    )
                ),


                // Container(
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         color:  Color.fromARGB(255,27, 77, 104),
                //
                //
                //         borderRadius: BorderRadius.circular(15)),
                //     child:  Column(
                //         children: [
                //           SizedBox(height: 5.0),
                //           InkWell(
                //
                //             child: CircleAvatar(
                //                 radius: 50,
                //                 backgroundImage:AssetImage('assets/ip.jpg')
                //             ),
                //             onTap: () {
                //               Navigator.push(context, MaterialPageRoute(
                //               builder: (context) => Driver_Change_Password(title:""),));
                //               },
                //           ),
                //           SizedBox(height: 10.0),
                //           // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                //           Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(1),
                //                 child: Text("Change password",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                //                 )),
                //               ),],
                //           ),
                //
                //
                //         ]
                //     )
                // ),





                Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:  Color.fromARGB(255,27, 77, 104),


                        borderRadius: BorderRadius.circular(15)),
                    child:  Column(
                        children: [
                          SizedBox(height: 5.0),
                          InkWell(

                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage:AssetImage('assets/ip.jpg')
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) => LoginScreen(title: "",),));
                              },
                          ),
                          SizedBox(height: 10.0),
                          // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(1),
                                child: Text("Logout",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                                )),
                              ),],
                          ),


                        ]
                    )
                ),
                // Container(
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         color:  Color.fromARGB(255,27, 77, 104),
                //
                //
                //         borderRadius: BorderRadius.circular(15)),
                //     child:  Column(
                //         children: [
                //           SizedBox(height: 5.0),
                //           InkWell(
                //
                //             child: CircleAvatar(
                //                 radius: 50,
                //                 backgroundImage: AssetImage('asset/obj.png')
                //             ),
                //             onTap: () {
                //               // Navigator.push(context, MaterialPageRoute(
                //               // builder: (context) => ViewRequestedMissingObject(title:""),));
                //               },
                //           ),
                //           SizedBox(height: 10.0),
                //           // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                //           Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(1),
                //                 child: Text("Request-Object",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                //                 )),
                //               ),],
                //           ),
                //
                //
                //         ]
                //     )
                // ),




                // Container(
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         color:  Color.fromARGB(255,27, 77, 104),
                //
                //
                //         borderRadius: BorderRadius.circular(15)),
                //     child:  Column(
                //         children: [
                //           SizedBox(height: 5.0),
                //           InkWell(
                //
                //             child: CircleAvatar(
                //                 radius: 50,
                //                 backgroundImage: AssetImage('asset/rating.png')
                //             ),
                //             onTap: () {
                //               // Navigator.push(context, MaterialPageRoute(
                //               // builder: (context) => ViewReview(),));
                //               },
                //           ),
                //           SizedBox(height: 10.0),
                //           // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                //           Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(1),
                //                 child: Text("Review",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                //                 )),
                //               ),],
                //           ),
                //
                //
                //         ]
                //     )
                // ),







                // Container(
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         color:  Color.fromARGB(255,27, 77, 104),
                //
                //
                //         borderRadius: BorderRadius.circular(15)),
                //     child:  Column(
                //         children: [
                //           SizedBox(height: 5.0),
                //           InkWell(
                //
                //             child: CircleAvatar(
                //                 radius: 50,
                //                 backgroundImage:AssetImage('asset/complaint.png')
                //             ),
                //             onTap: () {
                //               // Navigator.push(context, MaterialPageRoute(
                //               // builder: (context) => ViewReply(title: ""),));
                //               },
                //           ),
                //           SizedBox(height: 10.0),
                //           // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                //           Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(1),
                //                 child: Text("Complaints",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                //                 )),
                //               ),],
                //           ),
                //
                //
                //         ]
                //     )
                // ),

                // Container(
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         color:  Color.fromARGB(255,27, 77, 104),
                //
                //
                //         borderRadius: BorderRadius.circular(15)),
                //     child:  Column(
                //         children: [
                //           SizedBox(height: 5.0),
                //           InkWell(
                //
                //             child: CircleAvatar(
                //               radius: 50,
                //               backgroundImage: AssetImage('asset/feedback.png'),
                //             ),
                //             onTap: () {
                //               // Navigator.push(context, MaterialPageRoute(
                //               // builder: (context) => ViewFeedback(
                //               //   title: "",),));
                //               },
                //           ),
                //           SizedBox(height: 10.0),
                //           // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                //           Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(1),
                //                 child: Text("Feedback",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                //                 )),
                //               ),],
                //           ),
                //
                //
                //         ]
                //     )
                // ),

                // Container(
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         color:  Color.fromARGB(207, 28, 62, 100),
                //
                //
                //         borderRadius: BorderRadius.circular(15)),
                //     child:  Column(
                //         children: [
                //           SizedBox(height: 5.0),
                //           InkWell(
                //
                //             child: CircleAvatar(
                //                 radius: 50,
                //                 backgroundImage: NetworkImage('https://media.istockphoto.com/id/1429456277/photo/online-shopping-with-credit-car-or-cash-money.jpg?s=1024x1024&w=is&k=20&c=U-WywrpANXEOMnCB69B0UjEzZ1M4AEUIV4vi2idBmak=')
                //             ),
                //             onTap: () {Navigator.push(context, MaterialPageRoute(
                //               builder: (context) => MyRequestStatus(),));},
                //           ),
                //           SizedBox(height: 30.0),
                //           // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                //           Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(1),
                //                 child: Text("Request",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                //                 )),
                //               ),],
                //           ),
                //
                //
                //         ]
                //     )
                // ),


                // Container(
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         color:  Color.fromARGB(207, 28, 62, 100),
                //
                //
                //         borderRadius: BorderRadius.circular(15)),
                //     child:  Column(
                //         children: [
                //           SizedBox(height: 5.0),
                //           InkWell(
                //
                //             child: CircleAvatar(
                //                 radius: 50,
                //                 backgroundImage: NetworkImage('https://media.istockphoto.com/id/1429456277/photo/online-shopping-with-credit-car-or-cash-money.jpg?s=1024x1024&w=is&k=20&c=U-WywrpANXEOMnCB69B0UjEzZ1M4AEUIV4vi2idBmak=')
                //             ),
                //             onTap: () {Navigator.push(context, MaterialPageRoute(
                //               builder: (context) => MyRequestStatus(),));},
                //           ),
                //           SizedBox(height: 30.0),
                //           // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                //           Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(1),
                //                 child: Text("Booked Status",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                //                 )),
                //               ),],
                //           ),
                //
                //
                //         ]
                //     )
                // ),


                // Container(
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         color:  Color.fromARGB(255,27, 77, 104),
                //
                //
                //         borderRadius: BorderRadius.circular(15)),
                //     child:  Column(
                //         children: [
                //           SizedBox(height: 5.0),
                //           InkWell(
                //
                //             child: CircleAvatar(
                //                 radius: 50,
                //                 backgroundImage: NetworkImage('https://media.istockphoto.com/id/1429456277/photo/online-shopping-with-credit-car-or-cash-money.jpg?s=1024x1024&w=is&k=20&c=U-WywrpANXEOMnCB69B0UjEzZ1M4AEUIV4vi2idBmak=')
                //             ),
                //             onTap: () {Navigator.push(context, MaterialPageRoute(
                //               builder: (context) => MyLogin(),));},
                //           ),
                //           SizedBox(height: 10.0),
                //           // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                //           Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(1),
                //                 child: Text("Logout",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
                //                 )),
                //               ),],
                //           ),
                //
                //
                //         ]
                //     )
                // ),
              ],

            ),
          ),

          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color:  Color.fromARGB(255, 232, 177, 61),


                  ),
                  child:
                  Column(children: [

                    Text(
                      'Smart Cab',
                      style: TextStyle(fontSize: 20,color: Colors.grey[200]),

                    ),
                    CircleAvatar(radius: 50,backgroundImage: AssetImage('assets/ip.jpg')),




                  ])


                  ,
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DriverHome(title: "",),));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_pin),
                  title: const Text(' View Profile '),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Driver_Profile(title: ''),));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.request_page),
                  title: const Text(" Request "),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserRequestStatus(title: "",),));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.where_to_vote_sharp),
                  title: const Text(' Approved Request '),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserApprovedStatus(title: " ",),));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.unpublished),
                  title: const Text(' Rejected Request '),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserRejectedStatus(title: ""),));
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.medical_services_outlined),
                //   title: const Text(' View Test Details '),
                //   onTap: () {
                //     Navigator.pop(context);
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTestDetailsPage(title: "Test Details",),));
                //   },
                // ),
                //
                //
                // ListTile(
                //   leading: Icon(Icons.local_pharmacy),
                //   title: const Text(' View Pharmacy '),
                //   onTap: () {
                //     Navigator.pop(context);
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPharmacy(title: "Pharmacy",),));
                //   },
                //
                // ),
                //
                // ListTile(
                //   leading: Icon(Icons.payment_outlined),
                //   title: const Text('  '),
                //   onTap: () {
                //     Navigator.pop(context);
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMedicineOrderPage(title: "Medicine Order Details",),));
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.password),
                  title: const Text(' Change Password'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Driver_Change_Password(title: ''),));
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.lock_clock_rounded),
                //   title: const Text('Other Users '),
                //   onTap: () {
                //     // Navigator.pop(context);
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewOtherUserPage(title: "",),));
                //   },
                // ),
                // ListTile(
                //   leading: Icon(Icons.where_to_vote_sharp),
                //   title: const Text(' View Result '),
                //   onTap: () {
                //     // Navigator.pop(context);
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewResultPage(title: "View Complaint",),));
                //   },
                // ),
                // ListTile(
                //   leading: Icon(Icons.people),
                //   title: const Text(' Nominees'),
                //   onTap: () {
                //     // Navigator.pop(context);
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewNomineePage(title: "Send Feedback",),));
                //   },
                // ),
                // ListTile(
                //   leading: Icon(Icons.how_to_vote),
                //   title: const Text(' Elections'),
                //   onTap: () {
                //     // Navigator.pop(context);
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewElectionPage(title: "View Feedback",),));
                //   },
                // ),
                //
                // ListTile(
                //   leading: Icon(Icons.change_circle),
                //   title: const Text('Profile '),
                //   onTap: () {
                //     // Navigator.pop(context);
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfilePage(title: ""),));
                //   },
                // ),
                // ListTile(
                //   leading: Icon(Icons.request_page),
                //   title: const Text(' Add Waste Request '),
                //   onTap: () {
                //     // Navigator.pop(context);
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => MyRequestAdd(title: 'Add request',),));
                //   },
                // ),
                // ListTile(
                //   leading: Icon(Icons.request_page),
                //   title: const Text(' View Worker And Add Waste Request '),
                //   onTap: () {
                //     // Navigator.pop(context);
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DriverHome(title: 'View Worker',),));
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: const Text('LogOut'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyLoginPage(title: ""),));

                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(title: "",),));
                  },
                ),
              ],
            ),
          ),





        ));

  }

}