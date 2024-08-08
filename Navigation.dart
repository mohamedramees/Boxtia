import 'package:boxtia_inventory/Featurs/Bill_Image.dart';
import 'package:boxtia_inventory/Screens/Add_Item.dart';
import 'package:boxtia_inventory/Screens/Billing_Page.dart';
import 'package:boxtia_inventory/Screens/Display_image.dart';
import 'package:boxtia_inventory/Screens/Home_Page.dart';
import 'package:boxtia_inventory/Screens/Out_Of_Stock.dart';
import 'package:boxtia_inventory/Screens/Product_Page.dart';
import 'package:boxtia_inventory/Screens/Purchase_Report.dart';
import 'package:boxtia_inventory/Screens/Revenue_Page.dart';
import 'package:boxtia_inventory/Screens/Stock_Page.dart';
import 'package:flutter/material.dart';


//^ NAVIGATION TO STOCK

Future<void> navigationStock(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Stock_Page()),
  );
}

//^ NAVIGATION TO PRODUCT

Future<void> navigationProduct(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Product_Page()),
  );
}

//^ NAVIGATION TO ADDITEM

Future<void> navigationAddItem(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddItem()),
  );
}


//^ NAVIGATION TO HOME

Future<void> navigationHome(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Home_Page()),
  );
}


//^ NAVIGATION TO OUT OF STOCK

Future<void> navigationOutOfStock(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => OutOfStock()),
  );
}

//^ NAVIGATION TO SALES REPORT

Future<void> navigationSalesReport(BuildContext context) async {
  final updatedInvoiceModels = await fetchInvoiceModels();
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DisplayImageScreen(invoiceModels: updatedInvoiceModels),
    ),
  );
}


//^ NAVIGATION TO BILLING PAGE

Future<void> navigationBillingPage(BuildContext context) {
  return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BillingPage(
                selectedItems: [],
              )));
}


//^ NAVIGATION TO OUT OF STOCK

Future<void> navigationToPurchaseReport(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PurchaseReport()),
  );
}

//^ NAVIGATION TO REVENUE

Future<void> navigationToRevenue(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RevenuePage()),
  );
}
