import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'dart:io';

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
  @HiveField(5)
  bool sync = false;

  User(this.name, this.address, this.pname, this.sku, this.price, this.sync);
}

void saveUser(User user) {
  var userBox = Hive.box<User>("user");
  userBox.add(user);
  print("UserBox saved.");
  runsync();
}

Future<bool> checkConnection() async {
  bool connectivity;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      connectivity = true;
    }
  } on SocketException catch (_) {
    print('not connected');
    connectivity = false;
  }
  return connectivity;
}

void runsync() async {
  bool connectedState = await checkConnection();
  Box<User> box = Hive.box<User>('user');
  print(box.values);
  print("Conn STat:" + connectedState.toString());
  if (box.isNotEmpty && connectedState) {
    Map<dynamic, User> umap = box.toMap();
    for (var item in umap.keys) {
      if (!umap[item].sync) {
        print("sending ... " +
            umap[item].name +
            " status: " +
            umap[item].sync.toString());
        setData(umap[item]);
        umap[item].sync = true;
        if (box.containsKey(item)) {
          // await box.putAt(item, umap[item]);
          await box.delete(item);
        }
      }
    }
  } else {
    print("Box is Synced");
  }
  print(box.values);
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
