import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smart_cab/user/view_profile.dart';

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
      home: const UserEditProfile(title: 'Edit Profile'),
    );
  }
}

class UserEditProfile extends StatefulWidget {
  const UserEditProfile({super.key, required this.title});

  final String title;

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController pinController = TextEditingController();

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

  // final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
  //
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2100),
  //   );
  //
  //   if (picked != null) {
  //     setState(() {
  //       dobController.text = _dateFormatter.format(picked);
  //     });
  //   }
  // }

  // TextEditingController bloodController = TextEditingController();

  _UserEditProfileState() {
    _get_data();
  }

  // TextEditingController stateController = TextEditingController();
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String gender = "Male";
  // String intrest = "A+";

  String u_pic = "";

  var _formKey = GlobalKey<FormState>();

  void _get_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_view_profile/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
      });
      print(jsonDecode(response.body)['city']);

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'];
          String gender_ = jsonDecode(response.body)['gender'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['phone'].toString();
          String post = jsonDecode(response.body)['post'];
          String place = jsonDecode(response.body)['place'];
          String city = jsonDecode(response.body)['district'];
          // String type = jsonDecode(response.body)['blood'];
          String photo = sh.getString("imageurl").toString() +
              jsonDecode(response.body)['photo'];
          String dob = jsonDecode(response.body)['dob'];
          String pin = jsonDecode(response.body)['pin'].toString();

          setState(() {
            nameController.text = name;
            dobController.text = dob;
            emailController.text = email;
            phoneController.text = phone;
            placeController.text = place;
            postController.text = post;
            pinController.text = pin;
            districtController.text = city;
            // intrest = type;

            u_pic = photo;
            gender = gender_;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 232, 177, 61),

        // Here we take the value from the UserEditProfile object that was created by
        // the App.build method, and use it to set our appbar title.
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
                    height: 150,
                  ),
                  radius: 399,
                  onTap: _checkPermissionAndChooseImage,
                  // borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              } else ...{
                // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                InkWell(
                  onTap: _checkPermissionAndChooseImage,
                  child: Column(
                    children: [
                      // Image(
                      Image.network(
                        u_pic,
                        height: 200,
                        width: 200,
                      ),
                      Text('Select Image', style: TextStyle(color: Colors.cyan))
                    ],
                  ),
                ),
              },
              SizedBox(
                height: 2,
              ),
              // Image.asset('assets/photo.png', height: 90, width: 90),
              Padding(
                padding: EdgeInsets.all(7),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  validator: (v) {
                    if (v!.isEmpty || !RegExp(r"^[a-zA-Z]+").hasMatch(v)) {
                      return 'Must enter your Name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 2,
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

              // Padding(
              //   padding: EdgeInsets.all(7),
              //   child: TextFormField(
              //     controller: dobController,
              //     decoration: InputDecoration(
              //       labelText: 'DOB',
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(25)),
              //     ),
              //     validator: (v) {
              //       if (v!.isEmpty) {
              //         return 'Must enter valid DOB';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              SizedBox(
                height: 2,
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

              // Column(
              //   children: [
              //     RadioListTile(
              //         value: "Male",
              //         groupValue: gender,
              //         title: Text("Male"),
              //         onChanged: (value) {
              //           setState(() {
              //             gender = "Male";
              //           });
              //         }),
              //     RadioListTile(
              //         value: "Female",
              //         groupValue: gender,
              //         title: Text("Female"),
              //         onChanged: (value) {
              //           setState(() {
              //             gender = "Female";
              //           });
              //         }),
              //     RadioListTile(
              //         value: "Others",
              //         groupValue: gender,
              //         title: Text("Others"),
              //         onChanged: (value) {
              //           setState(() {
              //             gender = "Others";
              //           });
              //         }),
              //   ],
              // ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
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
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  validator: (v) {
                    if (v!.isEmpty || !RegExp(r"^[6789][0-9]{9}").hasMatch(v)) {
                      return 'enter valid number';
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: TextFormField(
                  controller: placeController,
                  decoration: InputDecoration(
                    labelText: 'Place',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Must enter valid place';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: TextFormField(
                  controller: postController,
                  decoration: InputDecoration(
                      labelText: 'Post',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25))),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Must enter valid post';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: TextFormField(
                  controller: districtController,
                  decoration: InputDecoration(
                    labelText: 'District',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  validator: (v) {
                    if (v!.isEmpty || !RegExp(r"^[a-zA_Z]+").hasMatch(v)) {
                      return 'Must enter valid District';
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
                child: TextFormField(
                  controller: pinController,
                  decoration: InputDecoration(
                      labelText: 'Pin',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25))),
                  validator: (v) {
                    if (v!.isEmpty || !RegExp(r"^[6][0-9]{5}").hasMatch(v)) {
                      return 'enter valid Pin';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 3,
              ),
              // Padding(
              //   padding: EdgeInsets.all(7),
              //   child: Row(
              //     children: [
              //       SizedBox(
              //           width: 220,
              //           child: Text(" Please Choose Your Blood Group : ")),
              //       SizedBox(
              //         width: 20,
              //       ),
              //       DropdownButton(
              //         value: intrest,
              //         // A variable to hold the selected item's value.
              //         onChanged: (String? newValue) {
              //           setState(() {
              //             intrest = newValue.toString();
              //             // Update the selected item when the user makes a selection.
              //           });
              //         },
              //         items: <String>[
              //           'A+',
              //           'A-',
              //           'B+',
              //           'B-',
              //           'O+',
              //           'O-',
              //           'AB+',
              //           'AB-',
              //         ].map<DropdownMenuItem<String>>((String value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: Text(value),
              //           );
              //         }).toList(),
              //       ),
              //     ],
              //   ),
              // ),
              // TextField(
              //   decoration: InputDecoration(
              //       labelText: 'State', border: OutlineInputBorder()),
              // ),
              SizedBox(
                height: 4,
              ),

              ElevatedButton(
                  onPressed: () {
                    _send_data();
                  },
                  child: Text("UPDATE"))
              // const Text(
              //   'You have pushed the button this many times:',
              // ),
              // Text(
              //   '$_counter',
              //   style: Theme.of(context).textTheme.headline4,
              // ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _send_data() async {
    String uname = nameController.text.toString();
    String dob = dobController.text.toString();
    String email = emailController.text.toString();
    String phone = phoneController.text.toString();
    String place = placeController.text.toString();
    String post = postController.text.toString();
    String pin = pinController.text.toString();
    String district = districtController.text.toString();
    // String blood = intrest.toString();

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_edit_profile/');
    try {
      final response = await http.post(urls, body: {
        "photo": photo,
        'name': uname,
        'dob': dob,
        'gender': gender,
        'email': email,
        'phone': phone,
        'place': place,
        'post': post,
        'pin': pin,
        'district': district,
        'lid': lid,
        // 'type': intrest,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Updated Successfully');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => User_Profile(title: ""),
              ));
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

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

  String photo = '';
}
