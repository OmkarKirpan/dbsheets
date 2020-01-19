import 'package:flutter/material.dart';
import 'package:dbsheets/fetchdata.dart';
import 'package:hive/hive.dart';
// import 'package:dbsheets/setdata.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    // void _pushSaved() {
    //   Navigator.of(context).push(
    //     MaterialPageRoute(builder: (BuildContext context) {
    //       return SetData();
    //     }),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("Ok Sheets"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.list),
        //     onPressed: _pushSaved,
        //   )
        // ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FetchData(
                url:
                    'https://script.google.com/macros/s/AKfycbxA4GeoaUQs8ZeTso6YvdpWqIp5jPCKhrCUgU6-/exec?action=get'),
            Padding(
              padding: EdgeInsets.only(top: 50.0),
            ),
            Text("By Omkar"),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    Hive.close();
    super.dispose();
  }
}
