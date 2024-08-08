import 'dart:io';

import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Featurs/FloatingButton.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class PurchaseReport extends StatefulWidget {
  const PurchaseReport({super.key});

  @override
  State<PurchaseReport> createState() => _PurchaseReportState();
}

class _PurchaseReportState extends State<PurchaseReport> {
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
    List<itemModel> items = box.values.toList();
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
            appBar: appBars('PURCHASES'),

//^ BODY
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Card(
                      color: AppColor.scaffold,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
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
                                  letterSpacing: -1.5,
                                  fontSize: 22),
                            ),
                          ),
                          subtitle: Column(
                            children: [

                              Column(
                                children: [
                                  Text(
                                  '${item.CountM} x ${item.PriceM} \nAmount :',
                                      style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                        color: AppColor.black,
                                        fontSize: 12,
                                        letterSpacing: -.8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(item.purchaseAmountM,
                                   style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                        color: AppColor.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
//^ FLOATING BUTTON
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 76.0),
              child: floatingToHome(context),
            ),
//^ BOTTOM NAV BAR
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(right: 85.0, bottom: 4.0),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: bottomNavBar(context,'purchase'),
              ),
            ),
          ),
        )
      ],
    );
  }
}
