import 'package:flutter/material.dart';
import 'package:dbsheets/myhome.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:dbsheets/model/user.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDir.path);
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Box<User> box = await Hive.openBox<User>('user');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.purple[900]),
      home: MyHome(),
    );
  }
}
