import 'dart:io';

import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Product_Page.dart';
import 'package:boxtia_inventory/Screens/Profile_Page.dart';
import 'package:boxtia_inventory/Screens/Stock_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
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
  String _businessName = '';

  @override
  void dispose() {
    _countControllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

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
      for (var i = 0; i < _items.length; i++) {
        _quantities[i] = int.tryParse(items[i].CountM)??0;
        _countControllers[i] = TextEditingController(text: items[i].CountM);
      }
    });
  }

  void _incrementQuantity(int index) {
    setState(() {
      _quantities[index] = (_quantities[index] ?? 0) + 1;
      _countControllers[index]?.text = _quantities[index].toString();
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_quantities[index]! > 0) {
        _quantities[index] = (_quantities[index] ?? 0) - 1;
        _countControllers[index]?.text = _quantities[index].toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Text(
                  "ADD SALE",
                  style: GoogleFonts.mogra(
                    textStyle: const TextStyle(
                      decorationColor: Colors.tealAccent,
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        toolbarHeight: 85,
      ),
      body: _items.isEmpty
          ? Center(child: Text('No items available!!!'))
          : GridView.builder(
              itemCount: _items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) {
                final item = _items[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: Color.fromARGB(214, 2, 21, 228),
                    color: Color.fromARGB(218, 255, 255, 255),
                    child: ClipRRect(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 9.0, left: 10, right: 10),
                            child: SizedBox(
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
                          Text(
                            item.ItemNameM,
                            style: GoogleFonts.robotoSlab(
                              textStyle: const TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                letterSpacing: -1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Text('\u{20B9}'),
                              ),
                              Text(
                                item.PriceM,
                                style: GoogleFonts.robotoSlab(
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 24, 115, 190),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Center(
                            child: Row(
                              children: [
                                // COUNT --
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromARGB(255, 17, 125, 213),
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            FontAwesome5.minus,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                          onPressed: () {
                                            _decrementQuantity(index);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      // COUNT TEXT FIELD
                                      Container(
                                        width: 70,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromARGB(255, 17, 125, 213),
                                        ),
                                        child: Center(
                                          child: TextFormField(
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  3),
                                            ],
                                            style: GoogleFonts.robotoSlab(
                                              color: Colors.white,
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            controller: _countControllers[index],
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 10),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                _quantities[index] =
                                                    int.tryParse(value) ?? 0;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      // COUNT ++
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromARGB(255, 17, 125, 213),
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            FontAwesome5.plus,
                                            color: Colors.white,
                                            size: 22, // Adjusted size
                                          ),
                                          onPressed: () {
                                            _incrementQuantity(index);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 76.0),
        child: FloatingActionButton(
          splashColor: Colors.lightBlueAccent,
          elevation: 20,
          onPressed: () {},
          child: Text(
            'SALE',
            style: GoogleFonts.odibeeSans(
              textStyle: TextStyle(
                color: Colors.cyanAccent[100],
                fontSize: 15,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
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
                    size: 32,
                  ),
                  color: Colors.white,
                ),
                IconButton(
                  tooltip: 'stock',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Stock_Page(),
                      ),
                    );
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
                        builder: (context) => Product_Page(),
                      ),
                    );
                  },
                  icon: Icon(
                    Zocial.paypal,
                    size: 30,
                  ),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
