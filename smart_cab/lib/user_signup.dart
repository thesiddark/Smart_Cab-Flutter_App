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

import 'main.dart';

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
      home: const UserSignup(title: 'SIGNUP'),
    );
  }
}

class UserSignup extends StatefulWidget {
  const UserSignup({super.key, required this.title});

  final String title;

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String gender = "Male";
  // String blood = "Yes";
  //
  // String intrest = "A+"; // Declare _selectedItem as a variable
  var _formKey = GlobalKey<FormState>();

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

  var _isLoading = 'false';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            child: Text(widget.title, textAlign: TextAlign.center),
            alignment: Alignment.center,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_selectedImage != null) ...{
                  InkWell(
                    child: Image.file(
                      _selectedImage!,
                      height: 200,
                      width: 200,
                    ),
                    radius: 300,
                    onTap: _checkPermissionAndChooseImage,
                    // borderRadius: BorderRadius.all(Radius.circular(200)),
                  ),
                } else ...{
                  // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                  InkWell(
                    onTap: _checkPermissionAndChooseImage,
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/camera.png'),
                          height: 150,
                          width: 150,
                        ),
                        Text('Select Image',
                            style: TextStyle(color: Colors.cyan))
                      ],
                    ),
                  ),
                },

                // Image.asset('assets/photo.png', height: 80, width: 40),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (v) {
                      if (v!.isEmpty || !RegExp(r"^[a-zA-Z]+").hasMatch(v)) {
                        return 'Must enter your Name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7),
                  child: TextFormField(
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
                            borderRadius: BorderRadius.circular(20))),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Must enter valid DOB';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: EdgeInsets.all(7),
                  child: Row(
                    children: [
                      Text(" Gender:"),
                      SizedBox(
                        width: .5,
                      ),
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
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (v) {
                      if (v!.isEmpty ||
                          !RegExp(r"^[6789][0-9]{9}").hasMatch(v)) {
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
                      labelText: 'Place',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
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
                      labelText: 'District',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (v) {
                      if (v!.isEmpty || !RegExp(r"^[a-zA_Z]+").hasMatch(v)) {
                        return 'Must enter valid District';
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
                      labelText: 'Pin',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (v) {
                      if (v!.isEmpty || !RegExp(r"^[6][0-9]{5}").hasMatch(v)) {
                        return 'enter valid Pin';
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
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
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
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid email!';
                      } else if (value != passwordController.text) {
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
                //         child: Text(" Please Choose Your Blood Group : ")),
                //     SizedBox(
                //       width: 20,
                //     ),
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
                    onPressed: () {
                      if (_formKey.currentState !.validate()) {
                        senddata();
                      }
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MyLoginPage(title: 'login'),
                      //   ),
                      // );
                    },
  // }else{
  // return null;
  // },
                    child: Text('submit')),
              ],
            ),
          ),
        )
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
    String password = passwordController.text;
    String cpassword = confirmPasswordController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url").toString();
    final urls = Uri.parse('$url/user_signup_post/');
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
        'district': district,
        'password': password,
        'cpassword': cpassword,
        // 'blood': intrest,
        // 'intrest': blood,
        'photo': photo,
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
          Fluttertoast.showToast(msg: "Password doesnt match");
        }
      } else {
        Fluttertoast.showToast(msg: "Not Found");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  String photo = '';
  File? uploadimage;
  File? _selectedImage;
  String? _encodedImage;

  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
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
