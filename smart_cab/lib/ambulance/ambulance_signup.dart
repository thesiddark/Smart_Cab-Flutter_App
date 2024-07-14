import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smart_cab/login.dart';
import 'package:smart_cab/newlogintemp.dart';

var _formKey = GlobalKey<FormState>();



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
      home: const AmbulanceSignupPage(title: 'SIGNUP'),
    );
  }
}

class AmbulanceSignupPage extends StatefulWidget {
  const AmbulanceSignupPage({super.key, required this.title});

  final String title;

  @override
  State<AmbulanceSignupPage> createState() => _AmbulanceSignupPageState();
}

class _AmbulanceSignupPageState extends State<AmbulanceSignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController regController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String gender = "Male";

  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');



  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        dobController.text = _dateFormatter.format(picked);
      });
    }
  }
  var _isLoading='false';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            child:
            Text(widget.title, textAlign: TextAlign.center),
            alignment: Alignment.center,
          ),
        ),
        body:
        SingleChildScrollView(
            child:Form(
              key: _formKey,
              child:
              Column(


                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[SizedBox(height: 20,),
                  Row( children: [SizedBox(width: 15,),if (_selectedImage1 != null) ...{
                    InkWell(
                      child: Image.file(
                        _selectedImage1!,
                        height: 90,
                        width: 90,
                      ),
                      radius: 60,
                      onTap: _checkPermissionAndChooseImage,
                      // borderRadius: BorderRadius.all(Radius.circular(200)),
                    ),
                  } else ...{
                    // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                    InkWell(
                      onTap: _checkPermissionAndChooseImage,
                      child:
                      Column(
                        children: [
                          Image(
                            image: NetworkImage(
                                'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
                            height: 90,
                            width: 90,
                          ),
                          Text('Select Photo', style: TextStyle(color: Colors.cyan))
                        ],
                      ),
                    ),
                  },SizedBox(width: 10,),
                    if (_selectedImage2 != null) ...{
                      InkWell(
                        child: Image.file(
                          _selectedImage2!,
                          height: 90,
                          width: 90,
                        ),
                        radius: 60,
                        onTap: _checkPermissionAndChooseImage2,
                        // borderRadius: BorderRadius.all(Radius.circular(200)),
                      ),
                    } else ...{
                      // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                      InkWell(
                        onTap: _checkPermissionAndChooseImage2,
                        child:
                        Column(
                          children: [
                            Image(
                              image: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
                              height: 90,
                              width: 90,
                            ),
                            Text('Select Proof', style: TextStyle(color: Colors.cyan))
                          ],
                        ),
                      ),
                    },SizedBox(width: 10,),if (_selectedImage3 != null) ...{
                      InkWell(
                        child: Image.file(
                          _selectedImage3!,
                          height: 90,
                          width: 90,
                        ),
                        radius: 60,
                        onTap: _checkPermissionAndChooseImage3,
                        // borderRadius: BorderRadius.all(Radius.circular(200)),
                      ),
                    } else ...{
                      // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                      InkWell(
                        onTap: _checkPermissionAndChooseImage3,
                        child:
                        Column(
                          children: [
                            Image(
                              image: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
                              height: 90,
                              width: 90,
                            ),
                            Text('Select Vehicle', style: TextStyle(color: Colors.cyan))
                          ],
                        ),
                      ),
                    },
                  ],),




                  // Image.asset('assets/photo.png', height: 80, width: 40),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.abc_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (v){
                        if(v!.isEmpty){
                          return 'Must enter your Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(padding: EdgeInsets.all(7),child:              TextFormField(
                    controller: dobController,
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                    decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        prefixIcon: Icon(Icons.date_range_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                        )
                    ),
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Must enter valid DOB';
                      }
                      return null;
                    },
                  ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(7),
                  //   child: TextFormField(
                  //     controller: dobController,
                  //     decoration: InputDecoration(
                  //       labelText: 'Date Of Birth',
                  //       prefixIcon: Icon(Icons.date_range_outlined),
                  //       floatingLabelBehavior: FloatingLabelBehavior.auto,
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(20)),
                  //     ),
                  //     validator: (v){
                  //       if(v!.isEmpty){
                  //         return 'Must enter valid DOB';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: EdgeInsets.all(7),
                    child: Row(
                      children: [
                        Text(" Gender:"),
                        SizedBox(width: .5,),
                        Radio(
                            value: "Male",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = "Male";
                              });
                            }),
                        Text("Male"),
                        SizedBox(
                          width: .5,
                        ),
                        Radio(
                            value: "Female",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = "Female";
                              });
                            }),
                        Text("Female"),
                        SizedBox(
                          width: .5,
                        ),
                        Radio(
                            value: "Others",
                            groupValue: gender,
                            // onChanged: (String? value) {
                            //   gender = "Others";
                            onChanged: (value) {
                              setState(() {
                                gender = "Others";
                              });
                            }),
                        Text("Others")
                      ],
                    ),
                  ),

                  // RadioListTile(
                  //     value: "Male",
                  //     groupValue: gender,
                  //     title: Text("Male"),
                  //     onChanged: (value) {
                  //       setState(() {
                  //         gender = "Male";
                  //       });
                  //     }),
                  // RadioListTile(
                  //     value: "Female",
                  //     groupValue: gender,
                  //     title: Text("Female"),
                  //     onChanged: (value) {
                  //       setState(() {
                  //         gender = "Female";
                  //       });
                  //     }),
                  // RadioListTile(
                  //     value: "Others",
                  //     groupValue: gender,
                  //     title: Text("Others"),
                  //     onChanged: (value) {
                  //       setState(() {
                  //         gender = "Others";
                  //       });
                  //     }),
                  Padding(
                    padding: EdgeInsets.all(7),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Enter a valid email!';
                        }
                        return null;
                      },
                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.all(7),
                    child: TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Phone',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (v){
                        if(v!.isEmpty ||
                            !RegExp(r"^[6789][0-9]{9}")
                                .hasMatch(v)) {

                          return 'enter valid number';
                        }

                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7),
                    child: TextFormField(
                      controller: placeController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.place_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Place',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (v){
                        if(v!.isEmpty){
                          return 'Must enter valid place';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7),
                    child: TextFormField(
                      controller: postController,
                      decoration: InputDecoration(
                        labelText: 'Post',
                        prefixIcon: Icon(Icons.post_add_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (v){
                        if(v!.isEmpty){
                          return 'Must enter valid post';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7),
                    child: TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.map_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'District',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (v){
                        if(v!.isEmpty||
                            !RegExp(r'^[A-Za-z\s]+$')
                                .hasMatch(v)){
                          return 'Must enter District';
                        }
                        return null;
                      },
                    ),
                  ),

                  // TextField(
                  //   controller: stateController,
                  //   decoration: InputDecoration(
                  //     labelText: 'State',
                  //     border: OutlineInputBorder(),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(7),
                    child: TextFormField(
                      controller: pinController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.pin_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Pin',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (v){
                        if(v!.isEmpty ||
                            !RegExp(r"^[6][0-9]{5}")
                                .hasMatch(v)) {

                          return 'enter valid Pin';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7),
                    child: TextFormField(
                      controller: regController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.pin_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Vehicle Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (v){
                        if(v!.isEmpty ||
                            !RegExp(r"^[A-Z]{2}[ -][0-9]{1,2}(?: [A-Z])?(?: [A-Z]*)? [0-9]{4}$")
                                .hasMatch(v)) {

                          return 'enter valid Number';
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(7),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (v){
                        if(v!.isEmpty){
                          return 'Must enter Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid Password!';
                        }
                        else if(value!=passwordController.text)
                        {
                          return 'Passwords Missmatch ';
                        }
                        return null;
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(7),
                  //   child: Row(children: [
                  //     SizedBox(
                  //         width: 200,
                  //         child: Text("  Please Choose Your Blood Group : ")),
                  //     DropdownButton(
                  //       value: intrest,
                  //       // A variable to hold the selected item's value.
                  //       onChanged: (String? newValue) {
                  //         setState(() {
                  //           intrest = newValue.toString();
                  //           // Update the selected item when the user makes a selection.
                  //         });
                  //       },
                  //       items: <String>[
                  //         'A+',
                  //         'A-',
                  //         'B+',
                  //         'B-',
                  //         'O+',
                  //         'O-',
                  //         'AB+',
                  //         'AB-',
                  //       ].map<DropdownMenuItem<String>>((String value) {
                  //         return DropdownMenuItem<String>(
                  //           value: value,
                  //           child: Text(value),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ]),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(7),
                  //   child: Row(
                  //     children: [
                  //       Text("  Donate blood ? :"),
                  //       Radio(
                  //           value: "Yes",
                  //           groupValue: blood,
                  //           onChanged: (value) {
                  //             setState(() {
                  //               gender = "Yes";
                  //             });
                  //           }),
                  //       Text("Yes"),
                  //       SizedBox(
                  //         width: 3,
                  //       ),
                  //       Radio(
                  //           value: "No",
                  //           groupValue: blood,
                  //           onChanged: (value) {
                  //             setState(() {
                  //               gender = "No";
                  //             });
                  //           }),
                  //       Text("No"),
                  //       SizedBox(
                  //         width: 3,
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // Row(children: [
                  //   Text("Please Choose Your Blood Group"),
                  //   RadioListTile(
                  //       value: "Yes",
                  //       groupValue: blood,
                  //       title: Text("Yes"),
                  //       onChanged: (value) {
                  //         setState(() {
                  //           blood = "Yes";
                  //         });
                  //       }),
                  //   RadioListTile(
                  //       value: "No",
                  //       groupValue: blood,
                  //       title: Text("No"),
                  //       onChanged: (value) {
                  //         setState(() {
                  //           blood = "No";
                  //         });
                  //       }),
                  // ]),
                  // Row(mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text("Are You intrested to donate blood? :"),
                  //
                  //   ],),
                  //   children: [
                  // Text("Are You intrested to donate blood?"),

                  //   ],
                  // ),

                  SizedBox(
                    height: 4,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if(uploadimage1==null){
                            senddata();
                          }
                          else{
                            Fluttertoast.showToast(
                                msg: "Upload photo",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 12.0
                            );

                          }
                        }if (_formKey.currentState!.validate()) {
                          if(uploadimage2==null){
                            senddata();
                          }
                          else{
                            Fluttertoast.showToast(
                                msg: "Upload photo",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 12.0
                            );

                          }
                        }if (_formKey.currentState!.validate()) {
                          if(uploadimage3==null){
                            senddata();
                          }
                          else{
                            Fluttertoast.showToast(
                                msg: "Upload photo",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 12.0
                            );

                          }
                        }
                        else{
                          Fluttertoast.showToast(
                              msg: "Fill all the fields",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 12.0
                          );
                        }
                      },

                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                          )
                      ),

                      child: Text('submit')),
                ],
              ),
            ))
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void senddata() async {
    String name = nameController.text;
    String dob = dobController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String place = placeController.text;
    String post = postController.text;
    String district = postController.text;
    String pin = pinController.text;
    String reg = regController.text;
    String password = passwordController.text;
    String cpassword = confirmPasswordController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url").toString();
    final urls = Uri.parse('$url/ambulance_driver_signup_post/');
    try {
      final response = await http.post(urls, body: {
        'name': name,
        'dob': dob,
        'gender': gender,
        'email': email,
        'phone': phone,
        'place': place,
        'post': post,
        'pin': pin,
        'regno': reg,
        'district': district,
        'password': password,
        'cpassword': cpassword,
        // 'blood': intrest,
        // 'intrest': blood,
        'photo': photo1,
        'vproof': photo2,
        'vphoto': photo3,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == "ok") {
          Fluttertoast.showToast(msg: "Successfully Registered..");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(title: "",),
              ));
        } else {
          Fluttertoast.showToast(msg: "Email Already Exists");
        }
      } else {
        Fluttertoast.showToast(msg: "Not found");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  String photo1 = '';
  String photo2 = '';
  String photo3 = '';
  File? uploadimage1;
  File? uploadimage2;
  File? uploadimage3;
  File? _selectedImage1;
  File? _selectedImage2;
  File? _selectedImage3;
  String? _encodedImage1;
  String? _encodedImage2;
  String? _encodedImage3;

  Future<void> _chooseAndUploadImage1() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage1 = File(pickedImage.path);
        _encodedImage1 = base64Encode(_selectedImage1!.readAsBytesSync());
        photo1 = _encodedImage1.toString();
      });
    }
    // if (pickedImage != null) {
    //   setState(() {
    //     _selectedImage2 = File(pickedImage.path);
    //     _encodedImage2 = base64Encode(_selectedImage2!.readAsBytesSync());
    //     photo2 = _encodedImage2.toString();
    //   });
    // }
    // if (pickedImage != null) {
    //   setState(() {
    //     _selectedImage3 = File(pickedImage.path);
    //     _encodedImage3 = base64Encode(_selectedImage3!.readAsBytesSync());
    //     photo3 = _encodedImage3.toString();
    //   });
    // }
  }
  Future<void> _chooseAndUploadImage2() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    // if (pickedImage != null) {
    //   setState(() {
    //     _selectedImage1 = File(pickedImage.path);
    //     _encodedImage1 = base64Encode(_selectedImage1!.readAsBytesSync());
    //     photo1 = _encodedImage1.toString();
    //   });
    // }
    if (pickedImage != null) {
      setState(() {
        _selectedImage2 = File(pickedImage.path);
        _encodedImage2 = base64Encode(_selectedImage2!.readAsBytesSync());
        photo2 = _encodedImage2.toString();
      });
    }
    // if (pickedImage != null) {
    //   setState(() {
    //     _selectedImage3 = File(pickedImage.path);
    //     _encodedImage3 = base64Encode(_selectedImage3!.readAsBytesSync());
    //     photo3 = _encodedImage3.toString();
    //   });
    // }
  }
  Future<void> _chooseAndUploadImage3() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    // if (pickedImage != null) {
    //   setState(() {
    //     _selectedImage1 = File(pickedImage.path);
    //     _encodedImage1 = base64Encode(_selectedImage1!.readAsBytesSync());
    //     photo1 = _encodedImage1.toString();
    //   });
    // }
    // if (pickedImage != null) {
    //   setState(() {
    //     _selectedImage2 = File(pickedImage.path);
    //     _encodedImage2 = base64Encode(_selectedImage2!.readAsBytesSync());
    //     photo2 = _encodedImage2.toString();
    //   });
    // }
    if (pickedImage != null) {
      setState(() {
        _selectedImage3 = File(pickedImage.path);
        _encodedImage3 = base64Encode(_selectedImage3!.readAsBytesSync());
        photo3 = _encodedImage3.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage1();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  Future<void> _checkPermissionAndChooseImage2() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage2();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  Future<void> _checkPermissionAndChooseImage3() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage3();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
