import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String name = '';
  @HiveField(1)
  String address = '';
  @HiveField(2)
  String pname = 'Mi Band 3';
  @HiveField(3)
  String sku = 'XMSH05HM';
  @HiveField(4)
  String price = '1599';

  User(this.name, this.address, this.pname, this.sku, this.price);
}

void saveUser(User user) {
  var userBox = Hive.box<User>("user");
  userBox.add(user);
  print("UserBox saved.");
}

Future<String> setData(User tuser) async {
  var queryParams = {
    'action': 'order',
    'name': tuser.name,
    'address': tuser.address,
    'pname': tuser.pname,
    'sku': tuser.sku,
    'price': tuser.price
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
  print('saving user using a web service ' + tuser.name);
  print(data['row']);

  return data['result'];
}
