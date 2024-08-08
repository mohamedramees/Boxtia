import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

//^ Functions for USER

ValueNotifier<List<userModel>> boxtiadb = ValueNotifier([]);

//  ADD USER

Future<void> addUser(userModel value) async {
  final boxtiadb = await Hive.openBox<userModel>('boxtiadb');
  boxtiadb.add(value);
}

// READ USER

Future<List<userModel>> getAllUsers() async {
  final boxtiadb = await Hive.openBox<userModel>('boxtiadb');
  List<userModel> users = boxtiadb.values.toList();
  return users;
}

//UPDATE USER

Future<void> updateUser(userModel user) async {
  final boxtiadb = await Hive.openBox<userModel>('boxtiadb');
  if (boxtiadb.isNotEmpty) {
    int key = boxtiadb.keyAt(0);
    await boxtiadb.put(key, user);
  } else {
    await boxtiadb.add(user);
  }
}

//^ Functions for ITEMS

ValueNotifier<List<itemModel>> boxtiaitemdb = ValueNotifier([]);
//ADD ITEM

Future<void> addItemF(itemModel value) async {
  final boxtiaitemdb = await Hive.openBox<itemModel>('boxtiaitemdb');
  boxtiaitemdb.add(value);
}

//READ ITEM

Future<List<itemModel>> getAllItems() async {
  final boxtiaitemdb = await Hive.openBox<itemModel>('boxtiaitemdb');
  List<itemModel> items = boxtiaitemdb.values.toList();
  return items;
}

//DELETE ITEM

Future<void> deleteItem(int index) async {
  final boxtiaitemdb = await Hive.openBox<itemModel>('boxtiaitemdb');
  await boxtiaitemdb.deleteAt(index);
}

//UPDATE ITEM

Future<void> updateItem(int index, itemModel item) async {
  final boxtiaitemdb = await Hive.openBox<itemModel>('boxtiaitemdb');
  if (index >= 0 && index < boxtiaitemdb.length) {
    int key = boxtiaitemdb.keyAt(index);
    await boxtiaitemdb.put(key, item);
  } else {
    throw RangeError('Index out of range: $index');
  }
}


//^ Functions for CUSTOMER

//ADD CUSTOMER

Future<void> addCustomerF(customerModel value) async {
  final boxtiacustomerdb = await Hive.openBox<customerModel>('boxtiacustomerdb');
  boxtiacustomerdb.add(value);
}

//READ CUSTOMER

Future<List<customerModel>> getCustomer() async {
  final boxtiacustomerdb = await Hive.openBox<customerModel>('boxtiacustomerdb');
  List<customerModel> items = boxtiacustomerdb.values.toList();
  return items;
}


//^ Functions for INVOICE

