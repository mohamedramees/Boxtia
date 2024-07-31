import 'dart:io';

import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Featurs/FloatingButton.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Home_Page.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class Stock_Page extends StatefulWidget {
  const Stock_Page({super.key});

  @override
  State<Stock_Page> createState() => _Stock_PageState();
}

class _Stock_PageState extends State<Stock_Page> {
  List<itemModel> _items = [];
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }


  void _fetchItems() async {
    final box = await Hive.openBox<itemModel>('boxtiaitemdb');
    List<itemModel> items = box.values.toList();
    setState(() {
      _items = items;

    });
  }

  void _sortItems(int value) {
    setState(() {
      _isAscending = value == 1;
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
      child: Stack(
        children: [
//^ BACKGROUND IMAGE
           Positioned.fill(
            child: Image.asset(
              'lib/asset/ScaffoldImage9.jpg',
              fit: BoxFit.cover,
            ),
          ),
         SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,

//^ APP BAR
            appBar: appBarStock(_sortItems),

//^ BODY

            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Card(
                    color: int.tryParse(item.CountM) != null &&
                            int.parse(item.CountM) > 0
                        ? AppColor.scaffold
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
                                color: AppColor.itemName,
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
                                'COUNT   :',
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
              child: floatingAddItemButton(context),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(right: 85.0, bottom: 4.0),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: bottomNavBar(context),
              ),
            ),
          ),
        ),
        ]
      ),
    );
  }
}
