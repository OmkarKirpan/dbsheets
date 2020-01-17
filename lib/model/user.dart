import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  String name = '';
  String address = '';

  String pname = 'Mi Band 3';
  String sku = 'XMSH05HM';
  String price = '1599';

  Future<String> setData() async {
    var queryParams = {
      'action': 'order',
      'name': name,
      'address': address,
      'pname': pname,
      'sku': sku,
      'price': price
    };
    var baseurl = Uri.https(
        "script.google.com",
        "/macros/s/AKfycbxA4GeoaUQs8ZeTso6YvdpWqIp5jPCKhrCUgU6-/exec",
        queryParams);
    var response = await http.get(
      baseurl,
      headers: {"Accept": "application/json"},
    );

    var data = json.decode(response.body);

    print(data['row']);

    return data['result'];
  }

  save() {
    print('saving user using a web service ' + name);
    setData();
  }
}
