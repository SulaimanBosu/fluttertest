import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';

class MyStyle {
  Color darkColor = Colors.blue.shade900;
  Color primaryColor = Colors.green.shade400;
  Color redColor = Colors.red;
  Color appbarColor = Colors.white;

  Color dark = Color(0xff005400);
  Color primary = Color(0xff39821a);
  Color lightCol = Color(0xff6bb249);




  void showToast(BuildContext context, String string) {
    Toast.show(
      string,
      context,
      duration: Toast.LENGTH_LONG,
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }

  Widget showProgress2(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
                fontSize: 15),
          ),
        ],
      ),
    );
  }

  TextStyle mainTitle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  TextStyle mainH2Title = TextStyle(
    fontSize: 14.0,
    // fontWeight: FontWeight.bold,
    color: Colors.black45,
    // fontStyle: FontStyle.italic,
    fontFamily: 'FC-Minimal-Regular',
  );

  TextStyle text2 = TextStyle(
    fontSize: 18.0,
    // fontWeight: FontWeight.bold,
    color: Colors.black45,
    // fontStyle: FontStyle.italic,
    fontFamily: 'FC-Minimal-Regular',
  );
  Text showtext_1(String title) => Text(
        title,
        style: mainH2Title,
      );

  Text showtext_2(String title) => Text(
        title,
        style: text2,
      );

  Text showTitle_2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          // fontWeight: FontWeight.bold,
          color: Colors.black45,
          fontFamily: 'FC-Minimal-Regular',
        ),
      );

  Text menu_1(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          // fontWeight: FontWeight.bold,
          color: Colors.black45,
          fontFamily: 'FC-Minimal-Regular',
        ),
      );
  Text menu_2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          // fontWeight: FontWeight.bold,
          color: Colors.black45,
          fontFamily: 'FC-Minimal-Regular',
        ),
      );
  Text textname_1(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black45,
          fontFamily: 'FC-Minimal-Regular',
        ),
      );
  Text textdetail_1(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black45,
          fontFamily: 'FC-Minimal-Regular',
        ),
      );

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Widget titleCenter(BuildContext context, String string) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Text(
          string,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Text showText(String title) => Text(
        title,
        style: TextStyle(
          color: Colors.black54,
          fontStyle: FontStyle.italic,
        ),
      );

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
          // fontStyle: FontStyle.italic,
          fontFamily: 'FC-Minimal-Regular',
        ),
      );

  Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          // fontWeight: FontWeight.bold,
          color: Colors.black45,
          fontFamily: 'FC-Minimal-Regular',
        ),
      );

  Text showTitleH2white(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      );

  Text showTitleCart(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          // fontStyle: FontStyle.italic,
          fontFamily: 'FC-Minimal-Regular',
        ),
      );

  Text showTitleH3(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blue.shade300,
          fontWeight: FontWeight.bold,
        ),
      );

  confirmDialog2(
    BuildContext context,
    String imageUrl,
    String textTitle,
    String textContent,
    Widget prossedYes,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Image.network(
              '$imageUrl',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            Text(textTitle)
          ]),
          content: Text(textContent),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text("ตกลง"),
              onPressed: () {
                Navigator.of(context).pop();
                // ใส่เงื่อนไขการกดตกลง
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (value) => prossedYes);
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
              },
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Text("ยกเลิก"),
              onPressed: () {
                // ใส่เงื่อนไขการกดยกเลิก

                Navigator.of(context).pop();
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        );
      },
    );
  }

  confirmDialog(
    BuildContext context,
    String textTitle,
    String textContent,
    Widget prossedYes,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [Text(textTitle)]),
          content: Text(textContent),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text("ตกลง"),
              onPressed: () {
                Navigator.of(context).pop();
                // ใส่เงื่อนไขการกดตกลง
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (value) => prossedYes);
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
              },
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Text("ยกเลิก"),
              onPressed: () {
                // ใส่เงื่อนไขการกดยกเลิก

                Navigator.of(context).pop();
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        );
      },
    );
  }

  Container showlogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showlogo2() {
    return Image(
      image: AssetImage('images/Logo1024.png'),
    );
  }

  BoxDecoration myBoxDecoration(String namePic) {
    return BoxDecoration(
      image: DecorationImage(
          image: AssetImage('images/$namePic'), fit: BoxFit.cover),
    );
  }

  easyLoading(BuildContext context) {
    EasyLoading.show(status: 'Loading... ');
  }

    easyLoading2() {
    EasyLoading.show();
  }

  dismiss(BuildContext context) {
    EasyLoading.dismiss();
  }

  showError() {
    EasyLoading.dismiss();
    EasyLoading.showError('ล้มเหลว');
  }

  Widget progress(BuildContext context) {
    return Container(
        child: new Stack(
      children: <Widget>[
        Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
            color: Colors.white70,
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
                      'ดาวน์โหลด...',
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

  MyStyle();
}
