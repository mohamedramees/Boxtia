import 'package:boxtia_inventory/Featurs/Navigation.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';

BottomAppBar bottomNavBar(BuildContext context) {
  return BottomAppBar(
    shadowColor: Colors.transparent,
    shape: const CircularNotchedRectangle(),
    notchMargin: 10.0,
    color: AppColor.bottomBar,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          tooltip: 'OutOfStock',
          onPressed: () {

          },
          icon: Icon(
            Octicons.stop,
            size: 32, // Reduced size
          ),
          color: AppColor.white,
        ),
        IconButton(
          tooltip: 'stock',
          onPressed: () {
            navigationStock(context);
          },
          icon: Icon(
            FontAwesome5.boxes,
            size: 30,
          ),
          color: AppColor.white,
        ),
        IconButton(
          tooltip: 'product',
          onPressed: () {
            navigationProduct(context);
          },
          icon: Icon(
            Zocial.paypal,
            size: 30, // Reduced size
          ),
          color: AppColor.white,
        ),
      ],
    ),
  );
}
