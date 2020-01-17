import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class FetchData extends StatefulWidget {
  FetchData({Key key, this.url}) : super(key: key);

  final String url;

  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  String data = 'Loding .... ';

  @override
  void initState() {
    super.initState();
    _get();
  }

  _get() async {
    final res = await http.get(widget.url);
    setState(() => data = _parseDataFromJson(res.body));
  }

  String _parseDataFromJson(String jsonStr) {
    final jsonData = json.decode(jsonStr);
    return jsonData['row'][0]['sku'];
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.center,
    );
  }
}
