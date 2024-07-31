import 'dart:io';

import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Functions/DB_Functions.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Invoice.dart';
import 'package:boxtia_inventory/Screens/Sales_Page.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
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
  final TextEditingController _customerNumberController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  ValueNotifier<String> _selectedCategory = ValueNotifier<String>('All');
  ValueNotifier<String> _searchKeyword = ValueNotifier<String>('');
  String search = 'Search Item Here...';
  List<itemModel> _items = [];
  final Map<int, int> _quantities = {};
  final Map<int, TextEditingController> _countControllers = {};

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

  double allTotal = 0.0;


//^INISTATE

  @override
  void initState() {
    super.initState();
    _fetchItems();
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

//^ DISPOSE

  @override
  void dispose() {
    _focusNodeName.dispose();
    _focusNodeNumber.dispose();
    _customerNameController.dispose();
    _customerNumberController.dispose();
    super.dispose();
  }

 //^FETCH ITEMS

  void _fetchItems() async {
    final Box = await Hive.openBox<itemModel>('boxtiaitemdb');
    List<itemModel> items = Box.values.toList();
    setState(() {
      _items = items;
    });
  }

//^ CUSTOMER REGISTRATION

  Future<void> _registerCustomer(BuildContext context) async {
    String _CustomerName = _customerNameController.text;
    String _CustomerNumber = _customerNumberController.text;

    customerModel saveCustomer = customerModel(customerNameM: _CustomerName, customerNumberM: _CustomerNumber);

    await addCustomerF(saveCustomer);

    Navigator.push(context, MaterialPageRoute(builder: (context) => InvoicePage()));
  }

//^ UPDATE QUANTITY

  void _updateQuantity(int index, int delta) {
    final currentItem = _items[index];
    int maxCount = int.parse(currentItem.CountM);
    int newQuantity = (_quantities[index] ?? 0) + delta;
    setState(() {
      if (newQuantity >= 0 && newQuantity <= maxCount) {
        _quantities[index] = newQuantity;
        _countControllers[index]?.text = newQuantity.toString();
      }
    });
  }

//^ DELETE ITEMS

  Future<void> deleteBillingItem(int index) async {
    setState(() {
      widget.selectedItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
// ^CALCULATE ALL TOTAL

    allTotal = widget.selectedItems.fold(0.0, (sum, item) {
      double price = double.tryParse(item.PriceM) ?? 0.0;
      double total = price * item.QuantityM;
      return sum + total;
    });
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SalesPage()),
        );
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
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

      //^APP BAR

                appBar: appBars("BILLING"),

      //^BODY

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

      //^ PRICE AND QUANTITY CALCULATION

                            double price = double.tryParse(item.PriceM) ?? 0.0;
                            double total = price * item.QuantityM;
      //^ MAIN LIST
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
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
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
      //^ DELETE BUTTON
                                    IconButton(
                                      onPressed: () {
                                        deleteBillingItem(index);
                                      },
                                      icon: Icon(
                                        Entypo.trash,
                                        color: Colors.redAccent[400],
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
      //^ QUANTITY TEXT
                                        Text(
                                          'Quantity:',
                                          style: GoogleFonts.arvo(
                                            textStyle: const TextStyle(
                                                color: Color.fromARGB(255, 235, 177, 2),
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: -.5,
                                                fontSize: 13),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
      //^ ITEM QUATITY
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
      //^ PRICE X QUANTITY
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
      //^ ITEM TOTAL PRICE
                                                Text(
                                                  '\u{20B9}',
                                                  textAlign: TextAlign.end,
                                                ),
                                                Text(
                                                  textAlign: TextAlign.end,
                                                  '$total',
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

      //^ TOTAL PRICE

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total : \u{20B9} ',
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

      //^ CUSTOMER DETAILES

                      Padding(
                        padding: const EdgeInsets.only(right: 220.0),
                        child: Text(
                          'Customer Details',
                          style: GoogleFonts.arvo(
                            textStyle: TextStyle(
                                color: AppColor.textFormBorder,
                                fontSize: 15,
                                letterSpacing: -1,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

      //^ CUSTOMER NAME
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.words,
                          focusNode: _focusNodeName,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: AppColor.white,
                          ),
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(12),
                          ],
                          controller: _customerNameController,
                          decoration: InputDecoration(

                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: AppColor.textFormBorder)),
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
                              borderSide: BorderSide(color: AppColor.lGreenAc),
                            ),
                          ),
                        ),
                      ),

      //^ CUSTOMER NUMBER
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          focusNode: _focusNodeNumber,
                          style: TextStyle(
                            color: AppColor.white,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          controller: _customerNumberController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: AppColor.textFormBorder)),
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
                              borderSide: BorderSide(color: AppColor.lGreenAc),
                            ),
                          ),
                        ),
                      ),

      //^ ADD ITEMS

                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Add Items',
                              style: GoogleFonts.arvo(
                                textStyle: TextStyle(
                                  color: AppColor.textFormBorder,
                                  fontSize: 15,
                                  letterSpacing: -1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

      //^ BOTTM SHEET

                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: AppColor.scaffold,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DraggableScrollableSheet(
                                        initialChildSize: .89,
                                        builder: (BuildContext context, ScrollController scrollController) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.scaffold,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: SizedBox(
                                              height: 800,
                                              width: 400,
                                              child: Column(
                                                children: [


                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                      left: 275.0,
                                                    ),
                                                    child: Row(
                                                      children: [
      //^ CLOSE ICON
                                                        IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            icon: Icon(
                                                              Elusive.down,
                                                              color: AppColor.white,
                                                            )),
      //^ SAVE BUTTON
                                                             ElevatedButton(onPressed: (){

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
                                                        child: Text('save'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 230.0, top: 10),
                                                    child:

      //^ SELECT ITEMS
                                                        Padding(
                                                      padding: const EdgeInsets.only(right: 35.0),
                                                      child: Text(
                                                        'Select Items',
                                                        style: GoogleFonts.arvo(
                                                          textStyle: TextStyle(
                                                            color: AppColor.white,
                                                            fontSize: 15,
                                                            letterSpacing: -1,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

      //^ SEARCH FIELD
                                                  Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                                                      child: TextField(
                                                        controller: _searchController,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _searchKeyword.value = value;
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          hintText: 'Search Item Here...',
                                                          filled: true,
                                                          fillColor: Colors.white,
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(15),
                                                            borderSide: BorderSide.none,
                                                          ),
                                                          prefixIcon: Icon(Linecons.search),
                                                          suffixIcon: _searchController.text.isNotEmpty
                                                              ? IconButton(
                                                                  icon: Icon(Icons.clear, color: Colors.black),
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      _searchController.clear();
                                                                      _searchKeyword.value = '';
                                                                    });
                                                                  },
                                                                )
                                                              : null,
                                                        ),
                                                      )),

      //^ BOTTOM SHEET LIST

                                                  Expanded(
                                                    child: ValueListenableBuilder<String>(
                                                      valueListenable: _searchKeyword,
                                                      builder: (context, searchKeyword, child) {
                                                        List<itemModel> filteredItems = _items
                                                            .where((item) => item.ItemNameM.toLowerCase()
                                                                .contains(searchKeyword.toLowerCase()))
                                                            .toList();

                                                        return ListView.builder(
                                                          itemCount: filteredItems.length,
                                                          itemBuilder: (context, index) {
                                                            final item = filteredItems[index];
                                                            final quantity = _quantities[index] ?? 0;
                                                            final controller = _countControllers[index];
                                                            int maxCount = int.parse(item.CountM);
                                                            return Padding(
                                                              padding: const EdgeInsets.symmetric(
                                                                  vertical: 0.0, horizontal: 5),
                                                              child: Card(
                                                                shadowColor: Colors.lightBlueAccent,
                                                                surfaceTintColor: Colors.lightBlueAccent,
                                                                child: Padding(
                                                                    padding: const EdgeInsets.all(12.0),
                                                                    child: ListTile(
                                                                      leading: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(15),
                                                                        child: Image.file(
                                                                          File(item.ItemPicM),
                                                                          width: 90,
                                                                          height: 100,
                                                                          fit: BoxFit.contain,
                                                                        ),
                                                                      ),
                                                                      title: Text(
                                                                        item.ItemNameM,
                                                                        style: GoogleFonts.arvo(
                                                                          textStyle: TextStyle(
                                                                            color: AppColor.itemName,
                                                                            fontWeight: FontWeight.bold,
                                                                            letterSpacing: -0.5,
                                                                            fontSize: 16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      subtitle: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    '\u{20B9}',
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    item.PriceM,
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Padding(
                                                                                padding:
                                                                                    const EdgeInsets.only(bottom: 6.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      'count = ',
                                                                                      style: GoogleFonts.robotoSlab(
                                                                                        textStyle: const TextStyle(
                                                                                          color: Color.fromARGB(
                                                                                              255, 162, 154, 154),
                                                                                          fontSize: 15,
                                                                                          letterSpacing: -1,
                                                                                          fontWeight: FontWeight.bold,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding:
                                                                                          const EdgeInsets.only(top: 3.0),
                                                                                      child: Text(
                                                                                        item.CountM,
                                                                                        style: TextStyle(
                                                                                          color: AppColor.black,
                                                                                          fontWeight: FontWeight.bold,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),

                                                                          // ^ ADD COUNTS

                                                                          Padding(
                                                                            padding: const EdgeInsets.only(top: 8.0),
                                                                            child: Center(
                                                                                child: Row(
                                                                              children: [
                                                                                //^ COUNT --

                                                                                Container(
                                                                                  width: 35,
                                                                                  height: 35,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius:
                                                                                        BorderRadius.circular(10),
                                                                                    color: AppColor.textFormBorder,
                                                                                  ),
                                                                                  child: IconButton(
                                                                                    onPressed: () {
                                                                                      if (quantity > 0) {
                                                                                        _updateQuantity(index, -1);
                                                                                      }
                                                                                    },
                                                                                    icon: Icon(
                                                                                      FontAwesome5.minus,
                                                                                      color: AppColor.white,
                                                                                      size: 15,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                //^ COUNT TEXT FIELD

                                                                                Container(
                                                                                  width: 50,
                                                                                  height: 35,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius:
                                                                                        BorderRadius.circular(10),
                                                                                    color: AppColor.textFormBorder,
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: TextFormField(
                                                                                      inputFormatters: [
                                                                                        LengthLimitingTextInputFormatter(
                                                                                            3),
                                                                                      ],
                                                                                      style: GoogleFonts.robotoSlab(
                                                                                        color: AppColor.white,
                                                                                        fontSize: 22,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                      controller:
                                                                                          _countControllers[index] ??=
                                                                                              TextEditingController(
                                                                                                  text: '0'),
                                                                                      keyboardType: TextInputType.number,
                                                                                      textAlign: TextAlign.center,
                                                                                      decoration: InputDecoration(
                                                                                        border: InputBorder.none,
                                                                                        contentPadding:
                                                                                            EdgeInsets.only(bottom: 10),
                                                                                      ),
                                                                                      onChanged: (value) {
                                                                                        int newValue =
                                                                                            int.tryParse(value) ?? 0;
                                                                                        if (newValue > maxCount) {
                                                                                          controller?.text =
                                                                                              maxCount.toString();
                                                                                        } else {
                                                                                          setState(() {
                                                                                            _quantities[index] = newValue;
                                                                                          });
                                                                                        }
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                //^ COUNT ++

                                                                                Container(
                                                                                  width: 35,
                                                                                  height: 35,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius:
                                                                                        BorderRadius.circular(10),
                                                                                    color: AppColor.textFormBorder,
                                                                                  ),
                                                                                  child: IconButton(
                                                                                    icon: Icon(
                                                                                      FontAwesome5.plus,
                                                                                      color: AppColor.white,
                                                                                      size: 15,
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      _updateQuantity(index, 1);
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                );
                              },
                              icon: Icon(
                                FontAwesome.plus,
                                size: 30,
                                color: Colors.white70,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

      //^ FLOATING BUTTON

                floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                floatingActionButton: Padding(
                  padding: const EdgeInsets.only(top: 76.0),
                  child: FloatingActionButton(
                    splashColor: Colors.lightBlueAccent,
                    elevation: 20,
                    onPressed: () {
                      _registerCustomer(context);
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
      ),
    );
  }
}
