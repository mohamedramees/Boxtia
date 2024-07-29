import 'dart:io';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:boxtia_inventory/Functions/DB_Functions.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Home_Page.dart';
import 'package:boxtia_inventory/Screens/Product_page.dart';
import 'package:boxtia_inventory/Screens/Profile_Page.dart';
import 'package:boxtia_inventory/Screens/Stock_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

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
  // final _CatList = ['Mobiles', 'Tablet', 'Watch', 'Accessories'];

  var _selectedBrand = 'Brands';
  // final _brandList = [
  //   'Samsung',
  //   'Apple',
  //   'Google',
  //   'Nothing',
  //   'Mi',
  //   'Oppo',
  //   'Vivo'
  // ];

  String _businessName = '';

  void _fetchBusinessName() async {
    final box = await Hive.openBox<userModel>('boxtiadb');
    List<userModel> users = box.values.toList();
    if (users.isNotEmpty) {
      setState(() {
        _businessName = users[0].bussinessName;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.item.CategoryM;
    _selectedBrand = widget.item.BrandM;
    pic = widget.item.ItemPicM;
    _fetchBusinessName();
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

  //IMAGE PICKER
  String? pic;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.safeArea,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.scaffold,
          //APP BAR
          appBar: AppBar(
            shadowColor: Colors.transparent,
            elevation: 10,
            backgroundColor: AppColor.appBar,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _businessName.isNotEmpty ? _businessName : "BOXTIA",
                style: GoogleFonts.goldman(
                  textStyle: const TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 25,
                      letterSpacing: -1,
                      fontWeight: FontWeight.bold),
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
                    child: Text(
                      "ITEM",
                      style: GoogleFonts.mogra(
                        textStyle: const TextStyle(
                            decorationColor: Colors.tealAccent,
                            color: AppColor.white,
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            toolbarHeight: 85,
          ),
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

                  //CATEGORY
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
                  //BRAND
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
                  //ITEM NAME
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
                  //COLOR
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
                  //PRICE
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
                  //COUNT
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

          //FLOATING ACTION BUTTON

          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 76.0),
            child: FloatingActionButton(
              splashColor: Colors.lightBlueAccent,
              elevation: 20,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home_Page(),
                  ),
                );
              },
              //HOME ICON

              child: Icon(Octicons.home),

              backgroundColor: AppColor.floating
            ),
          ),
          //BOTTOM APP BAR

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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Stock_Page()));
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
    );
  }
}
