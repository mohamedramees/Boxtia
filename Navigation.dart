import 'package:boxtia_inventory/Screens/Add_Item.dart';
import 'package:boxtia_inventory/Screens/Home_Page.dart';
import 'package:boxtia_inventory/Screens/Product_Page.dart';
import 'package:boxtia_inventory/Screens/Sales_Page.dart';
import 'package:boxtia_inventory/Screens/Stock_Page.dart';
import 'package:flutter/material.dart';


//NAVIGATION TO STOCK

Future<void> navigationStock(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Stock_Page()),
  );
}

//NAVIGATION TO SALES

Future<void> navigationSales(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SalesPage()),
  );
}

//NAVIGATION TO PRODUCT

Future<void> navigationProduct(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Product_Page()),
  );
}

//NAVIGATION TO ADDITEM

Future<void> navigationAddItem(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddItem()),
  );
}


//NAVIGATION TO HOME

Future<void> navigationHome(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Home_Page()),
  );
}