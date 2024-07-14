import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_cab/login.dart';
import 'package:smart_cab/newlogintemp.dart';
import 'package:smart_cab/user/changepassword.dart';
import 'package:smart_cab/user/driver_request_status.dart';
import 'package:smart_cab/user/user_view_ambulance_status.dart';
import 'package:smart_cab/user/view_ambulance_driver.dart';
import 'package:smart_cab/user/view_ambulance_payment.dart';
import 'package:smart_cab/user/view_cab.dart';
import 'package:smart_cab/user/view_cab_payment.dart';
import 'package:smart_cab/user/view_profile.dart';
import 'package:smart_cab/user/view_reply.dart';
import 'package:smart_cab/user/viewfeedback.dart';




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
      home: const UserHome(title: ''),
    );
  }
}

class UserHome extends StatefulWidget {
  const UserHome({super.key, required this.title});



  final String title;

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
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
              padding: const EdgeInsets.all(8.0),
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
                              builder: (context) => User_Profile(title: ""),));
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
                              builder: (context) => UserViewCab(title:""),));
                            },
                          ),
                          SizedBox(height: 10.0),
                          // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(1),
                                child: Text("Cab",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
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
                              builder: (context) => DriverRequestStatus(title:""),));
                            },
                          ),
                          SizedBox(height: 10.0),
                          // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(1),
                                child: Text(" Cab Request",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
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
                                backgroundImage:AssetImage('assets/Ambulance_red.png')
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) => UserViewAmbulance(title:""),));
                            },
                          ),
                          SizedBox(height: 10.0),
                          // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(1),
                                child: Text("Ambulance",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
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
                                backgroundImage: AssetImage('assets/Ambulance_yellow.png')
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) => UserViewAmbulanceStatus(title:""),));
                            },
                          ),
                          SizedBox(height: 10.0),
                          // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(1),
                                child: Text("Ambulance Req",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
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
                //                 backgroundImage:AssetImage('asset/lost_items.png')
                //             ),
                //             onTap: () {
                //               // Navigator.push(context, MaterialPageRoute(
                //               // builder: (context) => ViewAllMissingObject(title: "",),));
                //             },
                //           ),
                //           SizedBox(height: 10.0),
                //           // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                //           Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(1),
                //                 child: Text("Missing obj",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
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
                //                 backgroundImage: AssetImage('asset/obj.png')
                //             ),
                //             onTap: () {
                //               // Navigator.push(context, MaterialPageRoute(
                //               // builder: (context) => ViewRequestedMissingObject(title:""),));
                //             },
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
                //             },
                //           ),
                //           SizedBox(height: 10.0),
                //           // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                //           Column(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.all(1),
                //                 child: Text("Approved Request",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
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
                              builder: (context) => ViewCabPayment(title: ""),));
                            },
                          ),
                          SizedBox(height: 10.0),
                          // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(1),
                                child: Text("Cab Payment",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
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
                              backgroundImage: AssetImage('assets/ip.jpg'),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ViewAmbulancePayment(
                                title: "",),));
                            },
                          ),
                          SizedBox(height: 10.0),
                          // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(1),
                                child: Text("Ambulance pay",style: TextStyle(color: Colors.white,fontSize: 18,    fontWeight: FontWeight.bold,
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
                              backgroundImage: AssetImage('assets/ip.jpg'),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => MyLoginPage(
                                  title: "",),));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserHome(title: "",),));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_pin),
                  title: const Text(' View Profile '),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => User_Profile(title: ''),));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.car_repair),
                  title: const Text(" Cab "),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewCab(title: "",),));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.where_to_vote_sharp),
                  title: const Text(' Driver Request Status '),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DriverRequestStatus(title: " ",),));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.emergency),
                  title: const Text(' Ambulance Driver '),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewAmbulance(title: ""),));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.request_page),
                  title: const Text(' Ambulance Status '),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewAmbulanceStatus(title: "Test Details",),));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.payments),
                  title: const Text(' Ambulance Payment '),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAmbulancePayment(title: "",),));
                  },
                ),


                ListTile(
                  leading: Icon(Icons.payment),
                  title: const Text(' View Cab Payment '),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCabPayment(title: "",),));
                  },

                ),

                ListTile(
                  leading: Icon(Icons.border_color_outlined),
                  title: const Text(' Complaint '),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewReplyPage(title: "",),));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.password),
                  title: const Text(' Change Password'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => User_Change_Password(title: ''),));
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.payment_outlined),
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
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => UserHome(title: 'View Worker',),));
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