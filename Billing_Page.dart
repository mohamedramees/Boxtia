import 'dart:io';

import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Product_Page.dart';
import 'package:boxtia_inventory/Screens/Profile_Page.dart';
import 'package:boxtia_inventory/Screens/Stock_Page.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class BillingPage extends StatefulWidget {
  final List<itemModel> selectedItems;

  const BillingPage({super.key, required this.selectedItems});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  String _businessName = '';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
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
                      "BILLING",
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.selectedItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.selectedItems[index];
                      // PRICE AND QUANTITY CALCULATION
                      double price = double.tryParse(item.PriceM) ?? 0.0;
                      double total = price * item.QuantityM;
                      return Card(
                        child: ListTile(
                          leading: item.ItemPicM.isNotEmpty
                              ? Image.file(
                                  File(item.ItemPicM),
                                  width: 90,
                                  height: 100,
                                  fit: BoxFit.contain,
                                )
                              : Image.asset('lib/asset/no-image.png'),
                          title: Text(
                            item.ItemNameM,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.josefinSans(
                              textStyle: const TextStyle(
                                  decorationColor: Colors.tealAccent,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -1,
                                  fontSize: 22),
                            ),
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Quantity:',
                                    style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 235, 177, 2),
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -.5,
                                          fontSize: 13),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${item.QuantityM}',
                                    style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 12, 73, 216),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 30,),
                                  Column(
                                    children: [
                                      Text(
                                        '${item.PriceM} x ${item.QuantityM}',
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.arvo(
                                          textStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '\u{20B9}',
                                            textAlign: TextAlign.end,
                                          ),
                                          Text(
                                            textAlign: TextAlign.end,
                                            '$total',
                                            style: GoogleFonts.arvo(
                                              textStyle: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 4, 76, 136),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              // Row(mainAxisAlignment: MainAxisAlignment.end,
                              //       children: [
                              //         Text('\u{20B9}'),
                              //         Text(
                              //     '$total',
                              //       style: GoogleFonts.arvo(
                              //         textStyle: const TextStyle(
                              //           color: Color.fromARGB(255, 4, 76, 136),
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //     ),
                              //       ],
                              //     ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter some text',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 76.0),
            child: FloatingActionButton(
              splashColor: Colors.lightBlueAccent,
              elevation: 20,
              onPressed: () {
                // Implement the action for the SELL button
              },
              child: Text(
                'SELL',
                style: GoogleFonts.arvo(
                  textStyle: TextStyle(
                    color: Colors.cyanAccent[100],
                    fontSize: 15,
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
        ),
      ),
    );
  }
}
