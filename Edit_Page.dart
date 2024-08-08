import 'dart:io';
import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:boxtia_inventory/Functions/DB_Functions.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Product_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Edit_Item extends StatefulWidget {
  final itemModel item;
  final int index;

  Edit_Item({required this.item, required this.index});

  @override
  State<Edit_Item> createState() => _Edit_ItemState();
}

class _Edit_ItemState extends State<Edit_Item> {
  final TextEditingController _INameController = TextEditingController();
  final TextEditingController _ColorController = TextEditingController();
  final TextEditingController _PriceController = TextEditingController();
  final TextEditingController _countController = TextEditingController();

  String _selectedCategory = 'Mobiles';
  final _CatList = ['Mobiles', 'Tablet', 'Watch', 'Accessories'];
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

  void _InameClear() {
    _INameController.clear();
  }

  void _colorClear() {
    _ColorController.clear();
  }

  void _priceClear() {
    _PriceController.clear();
  }

  late int _quantity;
  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.item.CategoryM;
    _selectedBrand = widget.item.BrandM;
    pic = widget.item.ItemPicM;
    fetchAndSetItemData();
    _quantity = int.parse(widget.item.CountM);
    _countController.text = _quantity.toString();
  }

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
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

      });
    }
  }

  Future<void> _saveItem(BuildContext context) async {
    String _iCategory = _selectedCategory;
    String _iBrand = _selectedBrand;
    String _Iname = _INameController.text;
    String _IColor = _ColorController.text;
    String _Iprice = _PriceController.text;
    String _countI =
        _countController.text.isNotEmpty ? _countController.text : '0';
    int itemIndex = widget.index;

    if (_iCategory.isNotEmpty &&
        _iBrand.isNotEmpty &&
        _Iname.isNotEmpty &&
        _IColor.isNotEmpty &&
        _Iprice.isNotEmpty) {
      itemModel updatedItem = itemModel(
        CategoryM: _iCategory,
        BrandM: _iBrand,
        ItemNameM: _Iname,
        ColorM: _IColor,
        PriceM: _Iprice,
        ItemPicM: pic ?? '',
        CountM: _countI,
        purchaseAmountM: ''
      );

      await updateItem(itemIndex, updatedItem);

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
      fetchAndSetItemData();
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


  String capitalizeEachWord(String input) {
  // ignore: unnecessary_null_comparison
  if (input == null || input.isEmpty) return input;

  return input
      .split(' ') // Split the string into words
      .map((word) => word.isEmpty ? word : word[0].toUpperCase() + word.substring(1).toLowerCase()) // Capitalize the first letter and make the rest lowercase
      .join(' '); // Join the words back together with spaces
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

            appBar: appBars("EDIT ITEM"),

//^ BODY

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
                            color: AppColor.darkBlue,
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
                              .copyWith(canvasColor: AppColor.white),
                          child: Container(
                            child: DropdownButtonFormField(
                                value: _selectedCategory,
                                dropdownColor: Colors.blueAccent,
                                iconEnabledColor: AppColor.white,
                                iconSize: 35,
                                hint: Text(
                                  'Category',
                                  style: TextStyle(color: AppColor.white),
                                ),
                                decoration: InputDecoration(
                                  helperStyle: TextStyle(color: AppColor.white),
                                  hoverColor: Colors.blue,
                                  filled: true,
                                  fillColor:AppColor.darkBlue,
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
                              .copyWith(canvasColor: AppColor.white),
                          child: Container(
                            child: DropdownButtonFormField(
                                value: _selectedBrand,
                                dropdownColor: Colors.blueAccent,
                                iconEnabledColor: AppColor.white,
                                iconSize: 35,
                                hint: Text(
                                  'Brand',
                                  style: TextStyle(color: AppColor.white),
                                ),
                                decoration: InputDecoration(
                                  helperStyle: TextStyle(color: AppColor.white),
                                  hoverColor: Colors.blue,
                                  filled: true,
                                  fillColor:AppColor.darkBlue,
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
                                        style: TextStyle(
                                            color: Colors.cyanAccent[100]),
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedBrand = value as String;
                                  });
                                }),
                          ),
                        ),
                      ),

                      //ITEM NAME

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                           textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(16),
                          ],
                          controller: _INameController,
                          style: TextStyle(
                            color: Colors.cyanAccent[100],
                          ),
                          decoration: InputDecoration(
                              fillColor: AppColor.darkBlue,
                              filled: true,
                              hintStyle: TextStyle(color: AppColor.white),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _InameClear();
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: AppColor.white,
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
                              fillColor: AppColor.darkBlue,
                              filled: true,
                              hintStyle: TextStyle(color: AppColor.white),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _colorClear();
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: AppColor.white,
                                ),
                              ),
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
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                          ],
                          controller: _PriceController,
                          style: TextStyle(
                            color: Colors.cyanAccent[100],
                          ),
                          decoration: InputDecoration(
                              fillColor: AppColor.darkBlue,
                              filled: true,
                              hintStyle: TextStyle(color: AppColor.white),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _priceClear();
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: AppColor.white,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      //COUNT
                      Text(
                        'count',
                        style: GoogleFonts.robotoSlab(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
        //COUNT --
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 60,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.darkBlue,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  FontAwesome5.minus,
                                  color: AppColor.white,
                                  size: 27,

                                ),
                                onPressed: () {
                                  setState(() {
                                    if (_quantity > 0) {
                                      _quantity--;
                                      _countController.text =
                                          _quantity.toString();
                                    }
                                  });
                                },
                              ),
                            ),
                            // COUNT TEXT FIELD
                            Container(
                              width: 100,
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.darkBlue,
                              ),
                              child: Center(
                                child: TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(2),
                                  ],
                                  style: GoogleFonts.robotoSlab(
                                      color: Colors.cyanAccent[100],
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  controller: _countController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 10),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _quantity = int.parse(value);
                                    });
                                  },
                                ),
                              ),
                            ),
                            //COUNT ++

                            Container(
                              width: 60,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.darkBlue,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  FontAwesome5.plus,
                                  color: AppColor.white,
                                  size: 27,

                                ),
                                onPressed: () {
                                  setState(() {
                                    _quantity++;
                                    _countController.text = _quantity.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
                  'UPDATE',
                  style: GoogleFonts.odibeeSans(
                    textStyle: TextStyle(
                        color: Colors.cyanAccent[100],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                backgroundColor: AppColor.darkBlue,
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
                child: bottomNavBar(context,'editPage')
              ),
            ),
          ),
        ),
      ],
    );
  }
}
