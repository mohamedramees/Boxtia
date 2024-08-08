import 'package:boxtia_inventory/Featurs/Navigation.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/octicons_icons.dart';

//^ FLOATING ADD ITEM

FloatingActionButton floatingAddItemButton(BuildContext context) {
  return FloatingActionButton(
      tooltip: 'add item',
      splashColor: Colors.lightBlueAccent,
      elevation: 20,
      onPressed: () {
        navigationAddItem(context);
      },
      child: Icon(
        MfgLabs.plus,
        size: 25,
      ),
      backgroundColor: AppColor.darkBlue);
}

//^ FLOATING TO HOME

FloatingActionButton floatingToHome(BuildContext context) {
  return FloatingActionButton(
      splashColor: Colors.lightBlueAccent,
      elevation: 20,
      onPressed: () {
        navigationHome(context);
      },

      //HOME ICON

      child: Icon(Octicons.home),
      backgroundColor: AppColor.darkBlue);
}
