import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Splash_Sreen.dart';
import 'package:boxtia_inventory/services/AppColors.dart';

import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const saveKeyName = 'UserLoggedIn';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(userModelAdapter().typeId) &&
      !Hive.isAdapterRegistered(itemModelAdapter().typeId) &&
      !Hive.isAdapterRegistered(customerModelAdapter().typeId) &&
      !Hive.isAdapterRegistered(invoiceModelAdapter().typeId)) {
    Hive.registerAdapter(userModelAdapter());
    Hive.registerAdapter(itemModelAdapter());
    Hive.registerAdapter(customerModelAdapter());
    Hive.registerAdapter(invoiceModelAdapter());
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
        colorScheme: const ColorScheme.light(brightness: Brightness.light).copyWith(primary: AppColor.darkBlue),
      ),
      home: const Splash_Screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
