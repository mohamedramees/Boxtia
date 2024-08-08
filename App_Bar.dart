import 'package:boxtia_inventory/Featurs/Alert.dart';
import 'package:boxtia_inventory/Featurs/Date_Time.dart';
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
    backgroundColor:AppColor.darkBlue,
    automaticallyImplyLeading: false,
    title: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Text(
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
          Expanded(child:Container()),
             Padding(
               padding: const EdgeInsets.only(top: 47.0,),
               child: SizedBox(
                child: appBardateAndTime(),
                           ),
             ),

        ],
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
    backgroundColor:AppColor.darkBlue,
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
      Column(
        children: [
          IconButton(
            onPressed: () {
              showLogoutDialog(context);
            },
            icon: Icon(
              MfgLabs.logout,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0,top: 3),
            child: SizedBox(
            child: appBardateAndTime(),
            ),
          )
        ],
      ),
    ],
    toolbarHeight: 75,
  );
}

//^ STOCK APP BAR

AppBar appBarStock(void Function(int) onSortSelected) {
  return AppBar(
    shadowColor: Colors.transparent,
    elevation: 10,
    backgroundColor:AppColor.darkBlue,
    automaticallyImplyLeading: false,
    title: Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: Text(
        "STOCK",
        style: GoogleFonts.goldman(
          textStyle: const TextStyle(
            color: AppColor.white,
            fontSize: 25,
            letterSpacing: -1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    actions: [
      Row(
        children: [
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
                        padding: const EdgeInsets.only(top: 13),
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
Padding(
  padding: const EdgeInsets.only(top: 52.0,right: 14),
  child: SizedBox(
    child: appBardateAndTime(),
  ),
)
        ],
      ),
    ],
    toolbarHeight: 75,
  );
}

//^ SALES REPORT APP BAR

AppBar appBarSalesReport(Function(int) onSortSelected) {
  return AppBar(
    shadowColor: Colors.transparent,
    elevation: 10,
    backgroundColor: AppColor.darkBlue,
    automaticallyImplyLeading: false,
    title: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        "REPORT",
        style: GoogleFonts.goldman(
          textStyle: const TextStyle(
            color: AppColor.white,
            fontSize: 25,
            letterSpacing: -1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    actions: [
      Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  children: [
                    PopupMenuButton<int>(
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 13),
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
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 52.0, right: 14),
            child: SizedBox(
              child: appBardateAndTime(),
            ),
          ),
        ],
      ),
    ],
    toolbarHeight: 75,
  );
}

