import 'dart:io';

import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Featurs/FloatingButton.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class OutOfStock extends StatefulWidget {
   OutOfStock({super.key});

  @override
  State<OutOfStock> createState() => _OutOfStockState();
}

class _OutOfStockState extends State<OutOfStock> {
List<itemModel> _items = [];

//^ INISTATE

@override
  void initState() {
    super.initState();
    _fetchItems();
  }


//^ FETCH ITEMS

   void _fetchItems() async {
    final box = await Hive.openBox<itemModel>('boxtiaitemdb');
    List<itemModel> items = box.values
        .where((item) => int.tryParse(item.CountM) == 0)
        .toList();
    setState(() {
      _items = items;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
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
            backgroundColor: AppColor.scaffold,

//^ APP BAR

            appBar: appBars("OUT OF STOCK"),

//^ BODY
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
               itemCount: _items.length,
                itemBuilder: (context , index) {
                  final item = _items[index];
                return Card(
                  color:Color.fromARGB(255, 197, 15, 2) ,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                    color: AppColor.darkBlue,
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
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),

                                  ),

                                ],
                              ),
                            ),
                    ),
                  ),
                );
              }),
            ),

//^ FLOATING ACTION BUTTON

            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 76.0),
              child: floatingToHome(context),
            ),

//^ BOTTOM APP BAR

            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(right: 85.0, bottom: 4.0),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: bottomNavBar(context,'outOfStock'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
