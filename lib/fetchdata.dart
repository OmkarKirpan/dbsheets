import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dbsheets/setdata.dart';
import 'dart:convert';

class FetchData extends StatefulWidget {
  FetchData({Key key, this.url}) : super(key: key);

  final String url;

  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  List data;
  var dbdata;
  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<String> getData() async {
    var response = await http.get(Uri.encodeFull(widget.url),
        headers: {"Accept": "application/json"});

    this.setState(() {
      dbdata = json.decode(response.body);
      data = dbdata['row'];
    });

    print(data[0]['sku']);

    return "Success!";
  }

  Future<void> _refreshData() async {
    print('refreshing data...');
    await getData();
  }

  void _pushSaved(var data) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return SetData(pdata: data);
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
