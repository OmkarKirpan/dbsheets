import 'package:flutter/material.dart';
import 'package:dbsheets/fetchdata.dart';
// import 'package:dbsheets/setdata.dart';

class MyHome extends StatelessWidget {
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
}
