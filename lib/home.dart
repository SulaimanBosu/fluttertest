import 'package:flutter/material.dart';
import 'package:fluttertest/model/user_model.dart';
import 'package:fluttertest/profile.dart';
import 'package:fluttertest/utility/my_style.dart';

class Home extends StatefulWidget {
  final UserModel model;
  const Home({Key? key, required this.model}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late UserModel userModel;
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: MyStyle().appbarColor,
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 30.0, end: 30.0, bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.3,
                      child: Container(
                          child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.asset('images/4.png'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(0),
                      )),
                    ),
                    Text('โปรไฟล์'),
                  ],
                ),
                onTap: () {
                  routeToProfile(userModel);
                },
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.only(
                        start: 30.0, end: 30.0, bottom: 10),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.3,
                    child: Container(
                        child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset('images/3.png'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(0),
                    )),
                  ),
                  Text('รายการ'),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.only(
                        start: 30.0, end: 30.0, bottom: 10),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.3,
                    child: Container(
                        child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset('images/1.png'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(0),
                    )),
                  ),
                  Text('ประวัติการซ่อม'),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.only(
                        start: 30.0, end: 30.0, bottom: 10),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.3,
                    child: Container(
                        child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset('images/2.png'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(0),
                    )),
                  ),
                  Text('การตั้งค่า'),
                ],
              ),
            ],
          ),
        ],
      ),

      // Center(
      //   child: Text('Home Page\n' +
      //       userModel.userId.toString() +
      //       '\n' +
      //       userModel.name.toString() +
      //       '\n' +
      //       userModel.lastname.toString() +
      //       '\n' +
      //       userModel.phone.toString() +
      //       '\n' +
      //       userModel.username.toString() +
      //       '\n' +
      //       userModel.password.toString() +
      //       '\n'),
      // ),
    );
  }

  void routeToProfile(UserModel userModel) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => Profile(model: userModel),
    );
    Navigator.push(context, route);
    // Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
