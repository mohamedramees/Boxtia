import 'dart:io';

import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Screens/Home_Page.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:boxtia_inventory/Functions/DB_Functions.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Billing_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class SalesPage extends StatefulWidget {
  SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  final Map<int, TextEditingController> _countControllers = {};
  final Map<int, int> _quantities = {};

  List<itemModel> _items = [];


  @override
  void dispose() {
    _countControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

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
      for (int i = 0; i < _items.length; i++) {
        _countControllers[i] = TextEditingController(text: '0');
        _quantities[i] = 0;
      }
    });
  }

  void _updateQuantity(int index, int delta) {
    final currentItem = _items[index];
    int maxCount = int.parse(currentItem.CountM);

    setState(() {
      int newQuantity = (_quantities[index] ?? 0) + delta;

      if (newQuantity >= 0 && newQuantity <= maxCount) {
        _quantities[index] = newQuantity;
        _countControllers[index]?.text = newQuantity.toString();
      }
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
              backgroundColor: AppColor.scaffold,

      //^ APP BAR

              appBar: appBars("ADD SALES"),

      //^ BODY

              body: _items.isEmpty
                  ? Center(child: Text('No items available!!!'))
                  : GridView.builder(
                      itemCount: _items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .6,
                      ),
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        final controller = _countControllers[index];
                        final quantity = _quantities[index] ?? 0;
                        int maxCount = int.parse(item.CountM);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                           shadowColor: AppColor.white,
                            color: AppColor.scaffold,
                            child: ClipRRect(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 9, left: 10, right: 10),
                                    child: SizedBox(
      //^ IMAGE
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.file(
                                          File(item.ItemPicM),
                                          width: 130,
                                          height: 90,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                                  ),
      //^ ITEM NAME
                                  Text(
                                    item.ItemNameM,
                                    style: GoogleFonts.robotoSlab(
                                      textStyle: const TextStyle(
                                        color: AppColor.itemName,
                                        fontSize: 20,
                                        letterSpacing: -1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
      //^ PRICE
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: Text('\u{20B9}'),
                                      ),
                                      Text(
                                        item.PriceM,
                                        style: GoogleFonts.arvo(
                                          textStyle: const TextStyle(
                                            color: Color.fromARGB(255, 4, 76, 136),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
      //^COUNT

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'count =',
                                        style: GoogleFonts.robotoSlab(
                                          textStyle: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 17,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      ValueListenableBuilder(
                                          valueListenable: boxtiaitemdb,
                                          builder: (context, value, child) {
                                            return Text(
                                              value.isEmpty
                                                  ? item.CountM
                                                  : value.first.CountM.toString(),
                                              style: GoogleFonts.arvo(
                                                textStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 12, 73, 216),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            );
                                          })
                                    ],
                                  ),
                                  SizedBox(width: 5),
                                  Center(
                                    child: Row(
                                      children: [
      //^ COUNT --
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(width: 4),
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:AppColor.textFormBorder,
                                                ),
                                                child: IconButton(
                                                  icon: Icon(
                                                    FontAwesome5.minus,
                                                    color:AppColor.white,
                                                    size: 22,
                                                  ),
                                                  onPressed: () {
                                                    if (quantity > 0) {
                                                      _updateQuantity(index, -1);
                                                    }
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 5),
      //^ COUNT TEXT FIELD
                                              Container(
                                                width: 70,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:AppColor.textFormBorder,
                                                ),
                                                child: Center(
                                                  child: TextFormField(
                                                    inputFormatters: [
                                    LengthLimitingTextInputFormatter(
                                                          3),
                                                    ],
                                                    style: GoogleFonts.robotoSlab(
                                                      color:AppColor.white,
                                                      fontSize: 23,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    controller: controller,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 10),
                                                    ),
                                                    onChanged: (value) {
                                                      int newValue =
                                                          int.tryParse(value) ?? 0;
                                                      if (newValue > maxCount) {
                                                        controller?.text =
                                                            maxCount.toString();
                                                      } else {
                                                        setState(() {
                                                          _quantities[index] =
                                                              newValue;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5),
      //^ COUNT ++
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:AppColor.textFormBorder,
                                                ),
                                                child: IconButton(
                                                  icon: Icon(
                                                    FontAwesome5.plus,
                                                    color:AppColor.white,
                                                    size: 22,
                                                  ),
                                                  onPressed: () {
                                                    _updateQuantity(index, 1);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

      //^ FLOATING BUTTON

              floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(top: 76.0),
                child: FloatingActionButton(
                  splashColor: Colors.lightBlueAccent,
                  elevation: 20,
                  onPressed: () {
                   List<itemModel> selectedItems = [];
          _quantities.forEach((index, quantity) {
                if (quantity > 0) {
          final updatedItem = _items[index];
          final selectedItem = itemModel(
            ItemNameM: updatedItem.ItemNameM,
            PriceM: updatedItem.PriceM,
            CountM: updatedItem.CountM,
            ItemPicM: updatedItem.ItemPicM,
            CategoryM: updatedItem.CategoryM,
            ColorM: updatedItem.ColorM,
            BrandM: updatedItem.BrandM,
            QuantityM: quantity,
          );
          selectedItems.add(selectedItem);
                }
          });
          Navigator.push(
                context,
                MaterialPageRoute(
          builder: (context) => BillingPage(
            selectedItems: selectedItems,
          ),
                ),
          );
                  },
                  child: Text(
                    'BILL',
                    style: GoogleFonts.arvo(
                      textStyle: TextStyle(
                        color: Colors.cyanAccent[100],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  backgroundColor: AppColor.floating,
                ),
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
                  child: bottomNavBar(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
