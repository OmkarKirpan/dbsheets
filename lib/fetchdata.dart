import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:dbsheets/offlinewidget.dart';
import 'dart:convert';

class FetchData extends StatefulWidget {
  FetchData({Key key, this.url}) : super(key: key);

  final String url;

  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  List data = [
    {"sku": "D001", "name": "Dummy 1", "desc": "Dummy 1 watch", "price": 1696},
    {"sku": "D002", "name": "Dummy 2", "desc": "Dummy 2 watch", "price": 1969},
  ];
  var dbdata;
  String _products;
  @override
  void initState() {
    super.initState();
    var pBox = Hive.box("product");
    if (pBox.containsKey('products')) {
      data = jsonDecode(pBox.get("products"));
    } else {
      this.getData();
    }
    this.getData();
  }

  Future<String> getData() async {
    var response = await http.get(Uri.encodeFull(widget.url),
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

  Future<void> _refreshData() async {
    print('refreshing data...');
    print(_products);
    await getData();
  }

  void _pushSaved(var data) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return OfflineWidget(pdata: data);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: new ListView.builder(
        shrinkWrap: true,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new ListTile(
              title: new Text(data[index]["name"]),
              subtitle:
                  new Text(data[index]["sku"] + " " + data[index]["desc"]),
              onTap: () {
                _pushSaved(data[index]);
              },
            ),
          );
        },
      ),
      onRefresh: _refreshData,
    );
  }
}
