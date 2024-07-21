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

class BillingPage extends StatefulWidget {
  final List<itemModel> selectedItems;

  const BillingPage({super.key, required this.selectedItems});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerNumberController =
      TextEditingController();

  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeNumber = FocusNode();

  bool _isFocusedName = false;
  bool _isFocusedNumber = false;

  void _clearCname() {
    _customerNameController.clear();
  }

  void _clearCnumber() {
    _customerNumberController.clear();
  }

  String _businessName = '';

  @override
  void initState() {
    super.initState();
    _fetchBusinessName();
    _focusNodeName.addListener(() {
      setState(() {
        _isFocusedName = _focusNodeName.hasFocus;
      });
    });
    _focusNodeNumber.addListener(() {
      setState(() {
        _isFocusedNumber = _focusNodeNumber.hasFocus;
      });
    });
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

  String capitalizeEachWord(String input) {
    // ignore: unnecessary_null_comparison
    if (input == null || input.isEmpty) return input;

    return input
        .split(' ') // Split the string into words
        .map((word) => word.isEmpty
            ? word
            : word[0].toUpperCase() +
                word
                    .substring(1)
                    .toLowerCase()) // Capitalize the first letter and make the rest lowercase
        .join(' '); // Join the words back together with spaces
  }

  @override
  Widget build(BuildContext context) {
    double allTotal = 0.0;
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

                      // TOTAL PRICE

                      allTotal += total; 
                      
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
                                  SizedBox(
                                    width: 30,
                                  ),
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
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total : ',
                      style: GoogleFonts.arvo(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 4, 76, 136),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '$allTotal',
                      style: GoogleFonts.arvo(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 4, 76, 136),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                //CUSTOMER DETAILES

                Padding(
                  padding: const EdgeInsets.only(right: 200.0),
                  child: Text(
                    'Customer Details',
                    style: GoogleFonts.arvo(
                      textStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          letterSpacing: -1,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                //CUSTOMER NAME
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    focusNode: _focusNodeName,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    controller: _customerNameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue)),
                      labelText: 'Enter Customer Name Here',
                      suffixIcon: _isFocusedName
                          ? IconButton(
                              onPressed: _clearCname,
                              icon: Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                            )
                          : null,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),

                //CUSTOMER NUMBER
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    focusNode: _focusNodeNumber,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    controller: _customerNumberController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue)),
                      labelText: 'Enter Customer Number Here',
                      suffixIcon: _isFocusedNumber
                          ? IconButton(
                              onPressed: _clearCnumber,
                              icon: Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                            )
                          : null,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green),
                      ),
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
              onPressed: () {},
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
