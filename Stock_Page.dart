import 'dart:io';

import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Add_Item.dart';
import 'package:boxtia_inventory/Screens/Home_Page.dart';
import 'package:boxtia_inventory/Screens/Product_Page.dart';
import 'package:boxtia_inventory/Screens/Profile_Page.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class Stock_Page extends StatefulWidget {
  const Stock_Page({super.key});

  @override
  State<Stock_Page> createState() => _Stock_PageState();
}

class _Stock_PageState extends State<Stock_Page> {
  List<itemModel> _items = [];
  String _businessName = '';
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _fetchBusinessName();
    _fetchItems();
  }

  void _fetchBusinessName() async {
    final box = await Hive.openBox<userModel>('boxtiadb');
    List<userModel> users = box.values.toList();
    if (users.isNotEmpty) {
      setState(() {
        _businessName = users[0].bussinessName;
      });
    }
  }

  void _fetchItems() async {
    final box = await Hive.openBox<itemModel>('boxtiaitemdb');
    List<itemModel> items = box.values.toList();
    setState(() {
      _items = items;
    
    });
  }

  void _sortItems() {
    setState(() {
      _items.sort((a, b) {
        int countA = int.tryParse(a.CountM) ?? 0;
        int countB = int.tryParse(b.CountM) ?? 0;
        return _isAscending
            ? countA.compareTo(countB)
            : countB.compareTo(countA);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home_Page()),
        );
        return false;
      },
      child: Container(
        color: AppColor.safeArea,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.safeArea,
            appBar: AppBar(
              shadowColor: Colors.transparent,
              elevation: 10,
              backgroundColor: AppColor.appBar,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Text(
                  _businessName.isNotEmpty ? _businessName : "BOXTIA",
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
                              onSelected: (value) {
                                setState(() {
                                  _isAscending = value == 1;
                                  _sortItems();
                                });
                              },
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
                                  ]),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "STOCK",
                            style: GoogleFonts.mogra(
                              textStyle: const TextStyle(
                                decorationColor: Colors.tealAccent,
                                color: AppColor.white,
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              toolbarHeight: 85,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Card(
                    color: int.tryParse(item.CountM) != null &&
                            int.parse(item.CountM) > 1
                        ? Color.fromARGB(255, 247, 248, 249)
                        : Color.fromARGB(255, 197, 15, 2),
                    shadowColor: Colors.lightBlueAccent,
                    surfaceTintColor: Colors.lightBlueAccent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 15),
                      child: ListTile(
                        leading: Image.file(
                          File(
                            item.ItemPicM,
                          ),
                          alignment: Alignment.center,
                          width: 90,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                        title: Text(
                          item.ItemNameM,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.josefinSans(
                            textStyle: const TextStyle(
                                decorationColor: Colors.tealAccent,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1,
                                fontSize: 22),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'COUNT',
                                style: GoogleFonts.mogra(
                                  textStyle: const TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                item.CountM,
                                style: GoogleFonts.mogra(
                                  textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Icon(
                                Icons.donut_large_outlined,
                                color: int.tryParse(item.CountM) != null &&
                                        int.parse(item.CountM) > 10
                                    ? Colors.green
                                    : Colors.red,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 76.0),
              child: FloatingActionButton(
                tooltip: 'add item',
                splashColor: Colors.lightBlueAccent,
                elevation: 20,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddItem()),
                  );
                },
                child: Icon(
                  MfgLabs.plus,
                  size: 25,
                ),
                backgroundColor: AppColor.floating
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(right: 85.0, bottom: 4.0),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: BottomAppBar(
                  shadowColor: Colors.transparent,
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 10.0,
                  color: AppColor.bottomBar,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        tooltip: 'profile',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Profile_Page(),
                            ),
                          );
                        },
                        icon: Icon(
                          Typicons.user_outline,
                          size: 32, // Reduced size
                        ),
                        color: AppColor.white,
                      ),
                      IconButton(
                        tooltip: 'stock',
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Stock_Page()));
                        },
                        icon: Icon(
                          FontAwesome5.boxes,
                          size: 30,
                        ),
                        color: Colors.lightGreenAccent,
                      ),
                      IconButton(
                        tooltip: 'product',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Product_Page()));
                        },
                        icon: Icon(
                          Zocial.paypal,
                          size: 30, // Reduced size
                        ),
                        color: AppColor.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
