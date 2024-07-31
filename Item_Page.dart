import 'dart:io';
import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Featurs/FloatingButton.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:boxtia_inventory/Functions/DB_Functions.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';


class Item_Page extends StatefulWidget {
  final itemModel item;

  Item_Page({
    required this.item,
  });

  @override
  State<Item_Page> createState() => _Item_PageState();
}

class _Item_PageState extends State<Item_Page> {
  final TextEditingController _INameController = TextEditingController();
  final TextEditingController _ColorController = TextEditingController();
  final TextEditingController _PriceController = TextEditingController();
  final TextEditingController _CategoryController = TextEditingController();
  final TextEditingController _BrandController = TextEditingController();
  final TextEditingController _countController = TextEditingController();

  String _selectedCategory = 'Mobiles';
  var _selectedBrand = 'Brands';






  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.item.CategoryM;
    _selectedBrand = widget.item.BrandM;
    pic = widget.item.ItemPicM;
    fetchAndSetItemData();
  }

  void fetchAndSetItemData() async {
    List<itemModel> items = await getAllItems();
    if (items.isNotEmpty) {
      setState(() {
        pic = widget.item.ItemPicM;
        _selectedCategory = widget.item.CategoryM;
        _selectedBrand = widget.item.BrandM;
        _INameController.text = widget.item.ItemNameM;
        _ColorController.text = widget.item.ColorM;
        _PriceController.text = widget.item.PriceM;
        _CategoryController.text = _selectedCategory;
        _BrandController.text = _selectedBrand;
        _countController.text = widget.item.CountM;
      });
    }
  }

//^ IMAGE PICKER
  String? pic;

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

            appBar: appBars("ITEM"),


//^ BODY

            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    //IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: pic == null
                          ? Image.asset(
                              'lib/asset/no-image.png',
                            )
                          : Image.file(
                              alignment: Alignment.center,
                              width: 500,
                              height: 250,
                              File(pic!)),
                    ),
                    SizedBox(height: 20),

//^ CATEGORY
                    Text(
                      'CATEGORY',
                      style: GoogleFonts.mogra(
                        textStyle: TextStyle(
                            color: AppColor.textFormBorder,
                            fontSize:20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    AbsorbPointer(
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _CategoryController,
                        style: GoogleFonts.robotoSlab(
                          textStyle: TextStyle(
                              color: Colors.cyanAccent[100],
                              fontSize: 20,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                        decoration: InputDecoration(
                            hintText: 'Category',
                            fillColor: AppColor.textFormBorder,
                            filled: true,
                            hintStyle: TextStyle(color: AppColor.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
//^ BRAND
                    Text(
                      'BRAND',
                      style: GoogleFonts.mogra(
                        textStyle: TextStyle(
                           color: AppColor.textFormBorder,
                            fontSize:20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    AbsorbPointer(
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _BrandController,
                        style: GoogleFonts.robotoSlab(
                          textStyle: TextStyle(
                              color: Colors.cyanAccent[100],
                              fontSize: 20,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                        decoration: InputDecoration(
                            hintText: 'Brand',
                            fillColor: AppColor.textFormBorder,
                            filled: true,
                            hintStyle: TextStyle(color: AppColor.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
//^ ITEM NAME
                    Text(
                      'ITEM NAME',
                      style: GoogleFonts.mogra(
                        textStyle: TextStyle(
                            color: AppColor.textFormBorder,
                            fontSize:20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      enabled: false,
                      controller: _INameController,
                      style: GoogleFonts.robotoSlab(
                        textStyle: TextStyle(
                            color: Colors.cyanAccent[100],
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      decoration: InputDecoration(
                          fillColor: AppColor.textFormBorder,
                          filled: true,
                          hintStyle: TextStyle(color: AppColor.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
//^ COLOR
                    Text(
                      'COLOR',
                      style: GoogleFonts.mogra(
                        textStyle: TextStyle(
                            color: AppColor.textFormBorder,
                            fontSize:20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      enabled: false,
                      controller: _ColorController,
                      style: GoogleFonts.robotoSlab(
                        textStyle: TextStyle(
                            color: Colors.cyanAccent[100],
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      decoration: InputDecoration(
                          fillColor: AppColor.textFormBorder,
                          filled: true,
                          hintStyle: TextStyle(color: AppColor.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
//^ PRICE
                    Text(
                      'PRICE',
                      style: GoogleFonts.mogra(
                        textStyle: TextStyle(
                           color: AppColor.textFormBorder,
                            fontSize:20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      enabled: false,
                      textAlign: TextAlign.center,
                      controller: _PriceController,
                      style: GoogleFonts.robotoSlab(
                        textStyle: TextStyle(
                            color: Colors.cyanAccent[100],
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      decoration: InputDecoration(
                        fillColor: AppColor.textFormBorder,
                        filled: true,
                        hintStyle: TextStyle(color: AppColor.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
//^ COUNT
                    Text(
                      'COUNT',
                      style: GoogleFonts.mogra(
                        textStyle: TextStyle(
                            color: AppColor.textFormBorder,
                            fontSize:20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      controller: _countController,
                      style: GoogleFonts.robotoSlab(
                        textStyle: TextStyle(
                            color: Colors.cyanAccent[100],
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      decoration: InputDecoration(
                        fillColor: AppColor.textFormBorder,
                        filled: true,
                        hintStyle: TextStyle(color: AppColor.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                child:  bottomNavBar(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
