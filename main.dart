import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Splash_Sreen.dart';


import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const saveKeyName = 'UserLoggedIn';
Future<void> main() async {
  await Hive.initFlutter();
  if (
    !Hive.isAdapterRegistered(userModelAdapter().typeId)
    // &&
    // !Hive.isAdapterRegistered(itemModelAdapter().typeId)
    ) {
    Hive.registerAdapter(userModelAdapter());
    // Hive.registerAdapter(itemModelAdapter());
  }
  await Hive.openBox<bool>('userBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boxtia',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(brightness: Brightness.light)
            .copyWith(primary: Colors.blue),
      ),
      home: const Splash_Screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
