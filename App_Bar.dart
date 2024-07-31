import 'package:boxtia_inventory/Featurs/Alert.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:google_fonts/google_fonts.dart';

//^ APP BAR

AppBar appBars(String pageName) {
  return AppBar(
    shadowColor: Colors.transparent,
    elevation: 10,
    backgroundColor: AppColor.appBar,
    automaticallyImplyLeading: false,
    title: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        pageName,
        style: GoogleFonts.goldman(
          textStyle: const TextStyle(
            color: AppColor.white,
            fontSize: 20,
            letterSpacing: -1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    toolbarHeight: 75,
  );
}

//^ HOME APP BAR

AppBar appBarHome(String pageName, BuildContext context) {
  return AppBar(
    shadowColor: Colors.transparent,
    elevation: 10,
    backgroundColor: AppColor.appBar,
    automaticallyImplyLeading: false,
    title: Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: Text(
        "HOME",
        style: GoogleFonts.goldman(
          textStyle:
              const TextStyle(color: AppColor.white, fontSize: 20, letterSpacing: -1, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          showLogoutDialog(context);
        },
        icon: Icon(
          MfgLabs.logout,
          color: Colors.white,
        ),
      ),
    ],
    toolbarHeight: 75,
  );
}

//^ STOCK APP BAR

AppBar appBarStock(Function(int) onSortSelected) {
  return AppBar(
    shadowColor: Colors.transparent,
    elevation: 10,
    backgroundColor: AppColor.appBar,
    automaticallyImplyLeading: false,
    title: Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: Text(
        "STOCK",
        style: GoogleFonts.goldman(
          textStyle: const TextStyle(
            color: Colors.cyanAccent,
            fontSize: 25,
            letterSpacing: -1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    actions: [
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              children: [
                PopupMenuButton(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Icon(
                      FontAwesome5.sort,
                      color: Color.fromARGB(255, 7, 236, 118),
                    ),
                  ),
                  onSelected: onSortSelected,
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(FontAwesome5.sort_amount_up_alt),
                          SizedBox(width: 10),
                          Text('Ascending'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(FontAwesome5.sort_amount_down),
                          SizedBox(width: 10),
                          Text('Descending'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    ],
    toolbarHeight: 85,
  );
}

