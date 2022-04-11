import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertest/login.dart';
import 'package:fluttertest/model/user_model.dart';
import 'package:fluttertest/utility/my_style.dart';
import 'package:fluttertest/utility/normal_dialog.dart';
import 'package:fluttertest/utility/sqlite_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late double screenWidth;
  late double screenHight;
  String? name, lastname, phone, user, password, conpassword;
  bool statusRedEyepassword = true;
  bool statusRedEyeconpassword = true;
  File? file;
  final picker = ImagePicker();
  // bool uploadStatus = true;
  final fileName = 'No File Selected';
  late UserModel userModel;
  final _name = TextEditingController();
  final _lastname = TextEditingController();
  final _phone = TextEditingController();
  final _user = TextEditingController();
  final _password = TextEditingController();
  final _conpassword = TextEditingController();
  late FocusNode myFocusName;
  late FocusNode myFocusLastname;
  late FocusNode myFocusPhone;
  late FocusNode myFocusUsername;
  late FocusNode myFocusPassword;
  late FocusNode myFocusConpassword;

  @override
  void initState() {
    super.initState();
    myFocusName = FocusNode();
    myFocusLastname = FocusNode();
    myFocusPhone = FocusNode();
    myFocusUsername = FocusNode();
    myFocusPassword = FocusNode();
    myFocusConpassword = FocusNode();
  }

  @override
  void dispose() {
    myFocusName.dispose();
    myFocusLastname.dispose();
    myFocusPhone.dispose();
    myFocusUsername.dispose();
    myFocusPassword.dispose();
    myFocusConpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        centerTitle: true,
      ),
      body: buildContent(context),
    );
  }

  SafeArea buildContent(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return SafeArea(
      child: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        showImage(context),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(170, 35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            _showPicker(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                file == null ? 'เพิ่มรูปภาพ' : 'เปลี่ยนรูปโปรไฟล์',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontFamily: 'FC-Minimal-Regular',
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              fileName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: file == null ? Colors.redAccent : Colors.black54,
                                fontFamily: 'FC-Minimal-Regular',
                              ),
                            ),
                          ],
                        ),
                        MyStyle().mySizebox(),
                        nameForm(),
                        MyStyle().mySizebox(),
                        lastnameForm(),
                        MyStyle().mySizebox(),
                        phoneForm(),
                        MyStyle().mySizebox(),
                        userForm(),
                        MyStyle().mySizebox(),
                        passwordForm(),
                        MyStyle().mySizebox(),
                        conpasswordForm(),
                        MyStyle().mySizebox(),
                        registerButton(context),
                        MyStyle().mySizebox(),
                        MyStyle().mySizebox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //โชว์ภาพตัวอย่างก่อนเลือกรูปและหลังเลือกรูป
  Container showImage(context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 10.0, end: 10.0, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.6,
      child: Container(
          child: file == null
              ? CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('images/addimages1.png'),
                )
              : CircleAvatar(radius: 24, backgroundImage: FileImage(file!))),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        getImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      getImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  //ดึงรูปภาพจากมือถือมาใส่ในตัวแปร File
  Future<Null> getImage(ImageSource imageSource) async {
    try {
      // final pickedFile = await picker.getImage(
      //   source: imageSource,
      //   maxHeight: 400.0,
      //   maxWidth: 600.0,
      // );

      final result = await FilePicker.platform.pickFiles(allowMultiple: false);

      if (result == null) return;
      final path = result.files.single.path;

      setState(() => file = File(path!));
      if (file != null) {
        final fileName = basename(file!.path);
        final destination = 'files/$fileName';
        print('ชื่อรูปภาพ $fileName');
      }

      // setState(() {
      //   if (pickedFile != null) {
      //     file = File(pickedFile.path);
      //   } else {
      //     print('No image selected.');
      //   }
      // });
    } catch (e) {}
  }

  Widget registerButton(BuildContext context) => Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        width: screenWidth * 0.6,
        child: ElevatedButton.icon(
          onPressed: () {
            name = _name.value.text;
            lastname = _lastname.value.text;
            phone = _phone.value.text;
            user = _user.value.text;
            password = _password.value.text;
            conpassword = _conpassword.value.text;

            if (name!.isEmpty) {
              normalDialog(context, 'กรุณากรอกชื่อด้วยค่ะ');
              myFocusName.requestFocus();
            } else if (lastname!.isEmpty) {
              normalDialog(context, 'กรุณากรอกนามสกุลด้วยค่ะ');
              myFocusLastname.requestFocus();
            } else if (phone!.isEmpty) {
              normalDialog(context, 'กรุณากรอกเบอร์โทรด้วยค่ะ');
              myFocusPhone.requestFocus();
            } else if (user!.isEmpty) {
              normalDialog(context, 'กรุณากรอกชื่อเข้าใช้ด้วยค่ะ');
              myFocusUsername.requestFocus();
            } else if (password!.isEmpty) {
              normalDialog(context, 'กรุณากรอกรหัสผ่านด้วยค่ะ');
              myFocusPassword.requestFocus();
            } else if (conpassword!.isEmpty) {
              normalDialog(context, 'กรุณากรอกยืนยันรหัสผ่านด้วยค่ะ');
              myFocusConpassword.requestFocus();
            } else if (password != conpassword) {
              normalDialog(context, 'กรุณากรอกรหัสผ่านให้ตรงกันค่ะ');
              myFocusConpassword.requestFocus();
            } else {
              checkUser(context);
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          icon: Icon(Icons.cloud_upload_outlined),
          label: Text('Create Accound'),
        ),
      );

  Future<Null> checkUser(BuildContext context) async {
    try {
      SQLiteHelper().checkusername(user!).then((value) {
        if (value == true) {
          registerThread(context);
        } else {
          normalDialog(context, 'มีผู้ใช้บัญชี $user อยู่แล้ว');
        }
      });
    } catch (e) {
      normalDialog(context, e.toString());
    }
  }

  Future<Null> registerThread(BuildContext context) async {
    try {
      String? image = file != null ? file!.path : null;
      print('ชื่อภาพ  ==> $image');
      Map<String, dynamic> map = Map();
      // map['User_id'] = '';
      map['Name'] = name;
      map['Lastname'] = lastname;
      map['Phone'] = phone;
      map['Username'] = user;
      map['Password'] = password;
      map['File'] = image;
      userModel = UserModel.fromJson(map);
      await SQLiteHelper().insertDataToSQLite(userModel).then((value) {
        if (value == true) {
          registerlDialog(context);
        } else {
          normalDialog(context, 'สมัครสมาชิกล้มเหลว');
        }

        print('Insert เรียบร้อย= 0 Success\n $value');
      });

      // await SQLiteHelper()
      //     .insertToSQLite(name, lastname, phone, user, password,image)
      //     .then((value) {
      //     if (value == true) {
      //     registerlDialog(context);
      //   } else {
      //     normalDialog(context, 'สมัครสมาชิกล้มเหลว');
      //   }
      //   print('Insert Length = 0 Success\n $value');
      // });

    } catch (e) {
      normalDialog(context, e.toString());
      normalDialog(context, 'สมัครสมาชิกล้มเหลว');
    }
  }

  void routeToSignIn(BuildContext context, Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.85,
            child: TextField(
              //  onChanged: (value) => name = value.trim(),
              focusNode: myFocusName,
              autofocus: true,
              controller: _name,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.supervisor_account_outlined,
                  color: Colors.black54,
                ),
                labelStyle: TextStyle(
                  fontSize: 22.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  // fontStyle: FontStyle.italic,
                  fontFamily: 'FC-Minimal-Regular',
                ),
                labelText: 'Name : ',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black54)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
          ),
        ],
      );

  Widget lastnameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.85,
            child: TextField(
              //  onChanged: (value) => lastname = value.trim(),
              controller: _lastname,
              focusNode: myFocusLastname,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.black54,
                ),
                labelStyle: TextStyle(
                  fontSize: 22.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  // fontStyle: FontStyle.italic,
                  fontFamily: 'FC-Minimal-Regular',
                ),
                labelText: 'LastName : ',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black54)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
          ),
        ],
      );

  Widget phoneForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.85,
            child: TextField(
              //  onChanged: (value) => phone = value.trim(),
              controller: _phone,
              focusNode: myFocusPhone,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone_iphone,
                  color: Colors.black54,
                ),
                labelStyle: TextStyle(
                  fontSize: 22.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  // fontStyle: FontStyle.italic,
                  fontFamily: 'FC-Minimal-Regular',
                ),
                labelText: 'Phone : ',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black54)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
          ),
        ],
      );

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.85,
            child: TextField(
              //  onChanged: (value) => user = value.trim(),
              controller: _user,
              focusNode: myFocusUsername,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_box,
                  color: Colors.black54,
                ),
                labelStyle: TextStyle(
                  fontSize: 22.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  // fontStyle: FontStyle.italic,
                  fontFamily: 'FC-Minimal-Regular',
                ),
                labelText: 'Username : ',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black54)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.85,
            child: TextField(
              obscureText: statusRedEyepassword,
              focusNode: myFocusPassword,
              //   onChanged: (value) => password = value.trim(),
              controller: _password,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: statusRedEyepassword
                        ? Icon(
                            Icons.remove_red_eye,
                            color: Colors.black54,
                          )
                        : Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.black54,
                          ),
                    onPressed: () {
                      setState(() {
                        statusRedEyepassword = !statusRedEyepassword;
                      });
                    }),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black54,
                ),
                labelStyle: TextStyle(
                  fontSize: 22.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  // fontStyle: FontStyle.italic,
                  fontFamily: 'FC-Minimal-Regular',
                ),
                labelText: 'Password : ',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black54)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
          ),
        ],
      );

  Widget conpasswordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.85,
            child: TextField(
              obscureText: statusRedEyeconpassword,
              //   onChanged: (value) => conpassword = value.trim(),
              controller: _conpassword,
              focusNode: myFocusConpassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: statusRedEyeconpassword
                        ? Icon(
                            Icons.remove_red_eye,
                            color: Colors.black54,
                          )
                        : Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.black54,
                          ),
                    onPressed: () {
                      setState(() {
                        statusRedEyeconpassword = !statusRedEyeconpassword;
                      });
                    }),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.black54,
                ),
                labelStyle: TextStyle(
                  fontSize: 22.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  // fontStyle: FontStyle.italic,
                  fontFamily: 'FC-Minimal-Regular',
                ),
                labelText: 'Confirm Password : ',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black54)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
          ),
        ],
      );

  Widget progress(BuildContext context) {
    return Container(
        child: new Stack(
      children: <Widget>[
        buildContent(context),
        Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
            color: Colors.white24,
          ),
          child: new Container(
            decoration: new BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: new BorderRadius.circular(10.0)),
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.3,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: new CircularProgressIndicator(
                      value: null,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      'กำลังสมัครสมาชิก...',
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.black45,
                        fontFamily: 'FC-Minimal-Regular',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Future<void> registerlDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Row(children: [
                Icon(
                  Icons.notifications_active,
                  color: Colors.black54,
                ),
                MyStyle().mySizebox(),
                MyStyle().showTitle_2('Register'),
              ]),
              Divider(
                color: Colors.black54,
              ),
            ],
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyStyle().showtext_2('สมัครสมาชิกเรียบร้อย'),
            ],
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text("ตกลง"),
              onPressed: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, '/authen');
                routeToSignIn(context, Login());
              },
            ),
            // ignore: deprecated_member_use
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        );
      },
    );
  }
}
