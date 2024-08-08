import 'package:boxtia_inventory/Featurs/Navigation.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';

BottomAppBar bottomNavBar(BuildContext context , String currentPage) {
  return BottomAppBar(
    shadowColor: Colors.transparent,
    shape: const CircularNotchedRectangle(),
    notchMargin: 10.0,
    color: AppColor.scaffold,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          tooltip: 'OutOfStock',
          onPressed: () {
            navigationOutOfStock(context);
          },
          icon: Icon(
            Octicons.stop,
            size: 32,
          ),
        color: currentPage == 'outOfStock' ? AppColor.blue : AppColor.darkBlue,
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
          color: currentPage == 'stock' ? AppColor.blue : AppColor.darkBlue,
        ),
        IconButton(
          tooltip: 'product',
          onPressed: () {
            navigationProduct(context);
          },
          icon: Icon(
            Zocial.paypal,
            size: 30,
          ),
          color: currentPage == 'product' ? AppColor.blue : AppColor.darkBlue,
        ),
      ],
    ),
  );
}
