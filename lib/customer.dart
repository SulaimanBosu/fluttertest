import 'package:flutter/material.dart';

class CusToMer extends StatefulWidget {
  const CusToMer({Key? key}) : super(key: key);

  @override
  _CusToMerState createState() => _CusToMerState();
}

class _CusToMerState extends State<CusToMer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: MyStyle().appbarColor,
          ),
      body: Center(child: Text('CusToMer Page')),
    );
  }
}
