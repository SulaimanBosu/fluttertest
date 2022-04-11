import 'package:flutter/material.dart';
import 'package:fluttertest/customer.dart';
import 'package:fluttertest/home.dart';
import 'package:fluttertest/model/user_model.dart';
import 'package:fluttertest/utility/my_style.dart';
import 'package:fluttertest/register.dart';
import 'package:fluttertest/utility/normal_dialog.dart';
import 'package:fluttertest/utility/sqlite_helper.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? user, password;
  bool statusRedEye = true;
  late UserModel usermodel;
  final _user = TextEditingController();
  final _password = TextEditingController();
  late FocusNode myFocusUsername;
  late FocusNode myFocusPassword;

  @override
  void initState() {
    super.initState();
    myFocusUsername = FocusNode();
    myFocusPassword = FocusNode();
  }

  @override
  void dispose() {
    myFocusUsername.dispose();
    myFocusPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: MyStyle().appbarColor,
      //   title: Text('Sign In'),
      // ),
      body: buildContent(),
    );
  }

  Container buildContent() {
    return Container(
      decoration: BoxDecoration(
          // gradient: RadialGradient(
          //   colors: <Color>[Colors.white, MyStyle().redColor],
          //   center: Alignment(0, -0.3),
          //   radius: 1.0,
          // ),
          ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyStyle().showTitle('Login'),
              MyStyle().mySizebox(),
              SizedBox(
                width: 8.0,
                height: 16.0,
              ),
              SizedBox(
                width: 8.0,
                height: 16.0,
              ),
              userForm(),
              SizedBox(
                width: 8.0,
                height: 16.0,
              ),
              passwordForm(),
              SizedBox(
                width: 8.0,
                height: 16.0,
              ),
              loginButton(),
              SizedBox(
                width: 8.0,
                height: 16.0,
              ),
              forgot(),
            ],
          ),
        ),
      ),
    );
  }

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300.0,
            child: TextField(
              // onChanged: (value) => user = value.trim(),
              controller: _user,
              focusNode: myFocusUsername,
              autofocus: true,
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
                    borderSide: BorderSide(color: Colors.black54)),
                focusedBorder: OutlineInputBorder(
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
            width: 300.0,
            child: TextField(
              obscureText: statusRedEye,
              //  onChanged: (value) => password = value.trim(),
              controller: _password,
              focusNode: myFocusPassword,
              autofocus: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: statusRedEye
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
                        statusRedEye = !statusRedEye;
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
                    borderSide: BorderSide(color: Colors.black54)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
          ),
        ],
      );

  Widget loginButton() => Container(
        width: 300.0,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: Colors.black26,
          onPressed: () async {
          //  await SQLiteHelper().deleteAllData();
            user = _user.value.text;
            password = _password.value.text;
            if (user == null || user!.isEmpty) {
              normalDialog(context, 'กรุณากรอกชื่อเข้าใช้ด้วยค่ะ');
              myFocusUsername.requestFocus();
            } else if (password == null || password!.isEmpty) {
              normalDialog(context, 'กรุณากรอกรหัสผ่านด้วยค่ะ');
              myFocusPassword.requestFocus();
            } else {
              checkUser();
            }
          },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> checkUser() async {
    try {
      SQLiteHelper().checkusername(user!).then((value) {
        if (value == false) {
          loginThread();
        } else {
          normalDialog(context, 'ไม่พบบัญชีผู้ใช้ $user ในระบบ');
        }
      });
    } catch (e) {
      normalDialog(context, e.toString());
    }
  }

  Future<Null> loginThread() async {
    try {
      await SQLiteHelper()
          .checkusernameAndpassword(user!, password!)
          .then((value) async {
        if (value == true) {
          var object = await SQLiteHelper().readFromSQLite(user!, password!);
          if (object.length != 0) {
            for (var model in object) {
              setState(() {
                usermodel = model;
              });
            }
            routeToHome(usermodel);
          } else {
            print('ไม่พบข้อมูล');
          }
        } else {
          normalDialog(context, 'รหัสผ่านไม่ถูกต้อง');
          // await SQLiteHelper().deleteAllData();
        }
        print('$value');
      });
    } catch (e) {
      normalDialog(context, e.toString());
    }
  }

  void routeToHome(UserModel userModel) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => Home(model: userModel),
    );
  //  Navigator.push(context, route);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget forgot() {
    return Column(
      children: [
        Text(
          'OR',
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
            fontFamily: 'FC-Minimal-Regular',
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => CusToMer(),
                );
                Navigator.pushAndRemoveUntil(context, route, (route) => true);
              },
              child: Text(
                'forgot password',
                style: TextStyle(
                  fontSize: 22.0,
                  //fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  fontFamily: 'FC-Minimal-Regular',
                ),
              ),
            ),
            SizedBox(
              width: 2.0,
            ),
            Text(
              '/',
              style: TextStyle(
                fontSize: 22.0,
                //fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'FC-Minimal-Regular',
              ),
            ),
            SizedBox(
              width: 2.0,
            ),
            InkWell(
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Register(),
                );
                Navigator.push(context, route);
              },
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 22.0,
                  //fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontFamily: 'FC-Minimal-Regular',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
