import 'dart:io';

import 'package:boxtia_inventory/Functions/DB_Functions.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Product_Page.dart';
import 'package:boxtia_inventory/Screens/Profile_Page.dart';
import 'package:boxtia_inventory/Screens/Stock_Page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class Add_Item extends StatefulWidget {
  @override
  State<Add_Item> createState() => _Add_ItemState();
}

class _Add_ItemState extends State<Add_Item> {
  final TextEditingController _INameController = TextEditingController();
  final TextEditingController _ColorController = TextEditingController();
  final TextEditingController _PriceController = TextEditingController();
  final TextEditingController _newBrandController = TextEditingController();
  final TextEditingController _countController = TextEditingController();

  String _selectedCategory = 'Mobiles';
  final _CatList = ['Mobiles', 'Tablet', 'Watch', 'Accessories'];
  String _businessName = '';
  var _selectedBrand = 'Brands';

  final _brandList = [
    'Add Brand',
    'Samsung',
    'Apple',
    'Google',
    'Nothing',
    'Mi',
    'Oppo',
    'Vivo',
  ];
  bool _isAddingBrand = false;

  void _addNewBrand() {
    if (_newBrandController.text.isNotEmpty) {
      setState(() {
        _brandList.add(_newBrandController.text);
        _newBrandController.clear();
        _isAddingBrand = false;
      });
    }
  }

  String _ItemName = "Item Name";
  String _Color = "Color";
  String _Price = "Price";
  String _addNewBrandName = "Enter New Brand";

  void _InameClear() {
    _INameController.clear();
  }

  void _colorClear() {
    _ColorController.clear();
  }

  void _priceClear() {
    _PriceController.clear();
  }

  @override
  void initState() {
    super.initState();
    _fetchBusinessName();
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

  Future<void> _saveItem(BuildContext context) async {
    String _iCategory = _selectedCategory;
    String _iBrand = _selectedBrand;
    String _Iname = _INameController.text;
    String _IColor = _ColorController.text;
    String _Iprice = _PriceController.text;
    String _countI = _countController.text;

    if (_iCategory.isNotEmpty &&
        _iBrand != 'Add Brand' &&
        _iBrand.isNotEmpty &&
        _Iname.isNotEmpty &&
        _IColor.isNotEmpty &&
        pic!.isNotEmpty &&
        _Iprice.isNotEmpty) {
      // List<itemModel> existingItems = await getAllItems();
      itemModel newItem = itemModel(
        CategoryM: _iCategory,
        BrandM: _iBrand,
        ItemNameM: _Iname,
        ColorM: _IColor,
        PriceM: _Iprice,
        ItemPicM: pic ?? '',
        CountM: _countI,
      );

      await addItemF(newItem);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          duration: Duration(seconds: 1),
          content: Text('Item data saved successfully!'),
        ),
      );

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Product_Page()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 1),
            content: Text('Please fill in all fields.')),
      );
    }
  }

  //IMAGE PICKER
  String? pic;

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImg =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImg != null) {
      setState(() {
        pic = pickedImg.path;
      });
    }
  }

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
                      "ADD ITEM",
                      style: GoogleFonts.mogra(
                        textStyle: const TextStyle(
                            decorationColor: Colors.tealAccent,
                            color: Colors.white,
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
              child: Container(
                child: Column(
                  children: [
                    //IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: pic == null
                          ? Image.asset(
                              // color: Colors.amber,
                              'lib/asset/no-image.png',
                            )
                          : Image.file(
                              alignment: Alignment.center,
                              width: 500,
                              height: 250,
                              File(pic!)),
                    ),
                    Padding(
                      //ICON
                      padding: const EdgeInsets.only(left: 345.0),
                      child: IconButton(
                          iconSize: 30,
                          color: Color.fromARGB(255, 21, 127, 213),
                          onPressed: () {
                            pickImage();
                          },
                          icon: Icon(FontAwesome.camera_alt)),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //DROP DOWN CATEGORY
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(canvasColor: Colors.white),
                        child: Container(
                          child: DropdownButtonFormField(
                              dropdownColor: Colors.blueAccent,
                              iconEnabledColor: Colors.white,
                              iconSize: 35,
                              hint: Text(
                                'Category',
                                style: TextStyle(color: Colors.white),
                              ),
                              decoration: InputDecoration(
                                helperStyle: TextStyle(color: Colors.white),
                                hoverColor: Colors.blue,
                                filled: true,
                                fillColor: Color.fromARGB(255, 17, 125, 213),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              items: _CatList.map((e) {
                                return DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          color: Colors.cyanAccent[100]),
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value as String;
                                });
                              }),
                        ),
                      ),
                    ),

                    //DROP DOWN BRAND

                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(canvasColor: Colors.white),
                        child: Container(
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.blueAccent,
                            iconEnabledColor: Colors.white,
                            iconSize: 35,
                            hint: Text(
                              'Brand',
                              style: TextStyle(color: Colors.white),
                            ),
                            decoration: InputDecoration(
                              helperStyle: TextStyle(color: Colors.white),
                              hoverColor: Colors.blue,
                              filled: true,
                              fillColor: Color.fromARGB(255, 17, 125, 213),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            items: _brandList.map((e) {
                              return DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: e == 'Add Brand'
                                        ? TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          )
                                        : TextStyle(
                                            color: Colors.cyanAccent[100],
                                          ),
                                  ));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedBrand = newValue as String;
                                if (_selectedBrand == 'Add Brand') {
                                  _isAddingBrand = true;
                                } else {
                                  _isAddingBrand = false;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    //ADDING NEW BRAND

                    if (_isAddingBrand)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              style: TextStyle(
                                color: Colors.cyanAccent[100],
                              ),
                              controller: _newBrandController,
                              decoration: InputDecoration(
                                  hintText: _addNewBrandName,
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 17, 125, 213),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: _addNewBrand,
                                  ),
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                            ),
                          ),
                        ],
                      ),

                    //ITEM NAME

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
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
                            suffixIcon: IconButton(
                              onPressed: () {
                                _InameClear();
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                            ),
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
                        controller: _ColorController,
                        style: TextStyle(
                          color: Colors.cyanAccent[100],
                        ),
                        decoration: InputDecoration(
                          hintText: _Color,
                          fillColor: Color.fromARGB(255, 17, 125, 213),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _colorClear();
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    //PRICE
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                          FilteringTextInputFormatter.digitsOnly,
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
                          suffixIcon: IconButton(
                            onPressed: () {
                              _priceClear();
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    //COUNT
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 134),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _countController,
                        style: TextStyle(
                          color: Colors.cyanAccent[100],
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                              highlightColor: Colors.lightBlueAccent,
                              color: Colors.white,
                              onPressed: () {},
                              icon: Icon(FontAwesome5.minus)),
                          suffixIcon: IconButton(
                            focusColor: Colors.amberAccent,
                            highlightColor: Colors.lightBlueAccent,
                            color: Colors.white,
                            onPressed: () {},
                            icon: Icon(FontAwesome5.plus),
                          ),
                          fillColor: Color.fromARGB(255, 17, 125, 213),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
                _saveItem(context);
              },
              child: Text(
                'SAVE',
                style: GoogleFonts.odibeeSans(
                  textStyle: TextStyle(
                      color: Colors.cyanAccent[100],
                      fontSize: 15,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold),
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
