import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/model/user_model.dart';
import 'package:fluttertest/utility/normal_dialog.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Profile extends StatefulWidget {
  final UserModel model;
  const Profile({Key? key, required this.model}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late UserModel userModel;
  late double screenWidth;
  late double screenHight;
  TextEditingController usercontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController lastcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  File? file;
  final picker = ImagePicker();
  // bool uploadStatus = true;
  final fileName = 'No File Selected';

  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.model;
    setState(
        () => file = userModel.file != null ? File(userModel.file!) : null);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            // backgroundColor: MyStyle().appbarColor,
            ),
        body: showContent(context));
  }

  SingleChildScrollView showContent(context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    file == null ? fileName : 'ชื่อรูปภาพ : ' + fileName,
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: file == null ? Colors.redAccent : Colors.black54,
                      fontFamily: 'FC-Minimal-Regular',
                    ),
                  ),
                ],
              ),
              Container(
                width: screenWidth * 0.85,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'รหัสสมาชิก : ${userModel.userId}',
                      hintStyle: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black54,
                        fontFamily: 'FC-Minimal-Regular',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.85,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: TextField(
                    controller: usercontroller,
                    decoration: InputDecoration(
                      hintText: 'ชื่อเข้าใช้ : ${userModel.username}',
                      hintStyle: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black54,
                        fontFamily: 'FC-Minimal-Regular',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.85,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextField(
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      hintText: 'รหัสผ่าน : ${userModel.password}',
                      hintStyle: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black54,
                        fontFamily: 'FC-Minimal-Regular',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.85,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: TextField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      hintText: 'ชื่อ : ${userModel.name}',
                      hintStyle: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black54,
                        fontFamily: 'FC-Minimal-Regular',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.85,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: TextField(
                    controller: lastcontroller,
                    decoration: InputDecoration(
                      hintText: 'นามสกุล : ${userModel.lastname}',
                      hintStyle: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black54,
                        fontFamily: 'FC-Minimal-Regular',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.85,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: TextField(
                    controller: phonecontroller,
                    decoration: InputDecoration(
                      hintText: 'เบอร์ : ${userModel.phone}',
                      hintStyle: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black54,
                        fontFamily: 'FC-Minimal-Regular',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 80)),
                onPressed: () async {
                  //  SharedPreferences pref = await SharedPreferences.getInstance();
                  if (usercontroller.text.isEmpty ||
                      passwordcontroller.text.isEmpty ||
                      namecontroller.text.isEmpty) {
                    normalDialog(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
                  } else if (file == null) {
                    normalDialog(context, 'กรุณาเพิ่มรูปโปรไฟล์ด้วยคะ');
                  } else {}
                },
                child: Text(
                  'บันทึก',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    color: Colors.black54,
                    fontFamily: 'FC-Minimal-Regular',
                  ),
                ),
              ),
              SizedBox(height: 40),
              // task != null ? buildUploadStatus(task!) : Container(),
            ],
          ),
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
        uploadFile(context);
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

  Future uploadFile(context) async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';
    print('ชื่อรูปภาพ $destination');
  }
}
