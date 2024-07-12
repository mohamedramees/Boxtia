import 'dart:io';
import 'package:boxtia_inventory/Functions/DB_Functions.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Edit_Page.dart';
import 'package:boxtia_inventory/Screens/Product_page.dart';
import 'package:boxtia_inventory/Screens/Profile_Page.dart';
import 'package:boxtia_inventory/Screens/Stock_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class Item_Page extends StatefulWidget {
  final itemModel item;

  Item_Page({required this.item});

  @override
  State<Item_Page> createState() => _Item_PageState();
}

class _Item_PageState extends State<Item_Page> {
  final TextEditingController _INameController = TextEditingController();
  final TextEditingController _ColorController = TextEditingController();
  final TextEditingController _PriceController = TextEditingController();
  final TextEditingController _CategoryController = TextEditingController();
  final TextEditingController _BrandController = TextEditingController();

  String _selectedCategory = 'Mobiles';
  final _CatList = ['Mobile', 'Tablet', 'Watch', 'Accessories'];

  var _selectedBrand = 'Brands';
  final _brandList = [
    'Samsung',
    'Apple',
    'Google',
    'Nothing',
    'Mi',
    'Oppo',
    'Vivo'
  ];

  String _ItemName = "Item Name";
  String _Color = "Color";
  String _Price = "Price";
  List<itemModel> _items = [];

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
      });
    }
  }

  void _showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Category'),
          children: _CatList.map((category) {
            return SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _selectedCategory = category;
                  _CategoryController.text = category;
                });
                Navigator.pop(context);
              },
              child: Text(category),
            );
          }).toList(),
        );
      },
    );
  }

  void _showBrandDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Brand'),
          children: _brandList.map((brand) {
            return SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _selectedBrand = brand;
                  _BrandController.text = brand;
                });
                Navigator.pop(context);
              },
              child: Text(brand),
            );
          }).toList(),
        );
      },
    );
  }

  //IMAGE PICKER
  String? pic;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            elevation: 10,
            backgroundColor: Color.fromARGB(255, 21, 127, 213),
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "BOXTIA",
                style: GoogleFonts.mogra(
                  textStyle: const TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 30,
                      letterSpacing: 1,
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
                            color: Colors.tealAccent,
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
                  AbsorbPointer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _CategoryController,
                        style: TextStyle(
                          color: Colors.cyanAccent[100],
                        ),
                        decoration: InputDecoration(
                            hintText: 'Category',
                            fillColor: Color.fromARGB(255, 17, 125, 213),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
                    ),
                  ),

                  //BRAND
                  AbsorbPointer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _BrandController,
                        style: TextStyle(
                          color: Colors.cyanAccent[100],
                        ),
                        decoration: InputDecoration(
                            hintText: 'Brand',
                            fillColor: Color.fromARGB(255, 17, 125, 213),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
                    ),
                  ),

                  //ITEM NAME
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(16),
                      ],
                      controller: _INameController,
                      style: TextStyle(
                        color: Colors.cyanAccent[100],
                      ),
                      decoration: InputDecoration(
                          hintText: _ItemName,
                          fillColor: Color.fromARGB(255, 17, 125, 213),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  //COLOR
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      controller: _ColorController,
                      style: TextStyle(
                        color: Colors.cyanAccent[100],
                      ),
                      decoration: InputDecoration(
                          hintText: _Color,
                          fillColor: Color.fromARGB(255, 17, 125, 213),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  //PRICE
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                      ],
                      controller: _PriceController,
                      style: TextStyle(
                        color: Colors.cyanAccent[100],
                      ),
                      decoration: InputDecoration(
                          hintText: _Price,
                          fillColor: Color.fromARGB(255, 17, 125, 213),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
          builder: (context) => Edit_Item(item: widget.item),
        ),
      ).then((_) {
        // Refresh data after editing
        fetchAndSetItemData();
      });
    },
    child: Text(
      'EDIT',
      style: GoogleFonts.odibeeSans(
        textStyle: TextStyle(
          color: Colors.cyanAccent[100],
          fontSize: 17,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    ),
    backgroundColor: Color.fromARGB(255, 21, 127, 213),
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
                color: Color.fromARGB(255, 21, 127, 213),
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
                      color: Colors.white,
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
                      color: Colors.white,
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
                      color: Colors.white,
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

