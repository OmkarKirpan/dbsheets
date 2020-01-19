import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dbsheets/fetchdata.dart';
import 'package:hive/hive.dart';
// import 'package:dbsheets/setdata.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var dbdata;
  List data;
  String _products;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            'https://script.google.com/macros/s/AKfycbxA4GeoaUQs8ZeTso6YvdpWqIp5jPCKhrCUgU6-/exec?action=get'),
        headers: {"Accept": "application/json"});

    this.setState(() {
      dbdata = json.decode(response.body);
      data = dbdata['row'];
    });

    _products = jsonEncode(data);
    var pBox = Hive.box("product");
    pBox.put("products", _products);
    print("Products");
    print(_products);
    return "Success!";
  }

  Future<void> _refreshProducts() async {
    print('refreshing data...');
    print(_products);
    await getData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshProducts();
  }

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
        //     icon: Icon(Icons.refresh),
        //     onPressed: _refreshProducts,
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
