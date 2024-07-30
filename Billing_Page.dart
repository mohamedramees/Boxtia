import 'dart:io';

import 'package:boxtia_inventory/Functions/DB_Functions.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Invoice.dart';
import 'package:boxtia_inventory/Screens/Product_Page.dart';
import 'package:boxtia_inventory/Screens/Profile_Page.dart';
import 'package:boxtia_inventory/Screens/Stock_Page.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
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

  String _businessName = '';
  double allTotal = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchBusinessName();
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

  @override
  void dispose() {
    _focusNodeName.dispose();
    _focusNodeNumber.dispose();
    _customerNameController.dispose();
    _customerNumberController.dispose();
    super.dispose();
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

  //FETCH ITEMS

  void _fetchItems() async {
    final Box = await Hive.openBox<itemModel>('boxtiaitemdb');
    List<itemModel> items = Box.values.toList();
    setState(() {
      _items = items;
    });
  }

  String capitalizeEachWord(String input) {
    // ignore: unnecessary_null_comparison
    if (input == null || input.isEmpty) return input;

    return input
        .split(' ') // Split the string into words
        .map((word) => word.isEmpty
            ? word
            : word[0].toUpperCase() +
                word.substring(1).toLowerCase()) // Capitalize the first letter and make the rest lowercase
        .join(' '); // Join the words back together with spaces
  }

  Future<void> _registerCustomer(BuildContext context) async {
    String _CustomerName = _customerNameController.text;
    String _CustomerNumber = _customerNumberController.text;

    customerModel saveCustomer = customerModel(customerNameM: _CustomerName, customerNumberM: _CustomerNumber);

    await addCustomerF(saveCustomer);

    Navigator.push(context, MaterialPageRoute(builder: (context) => InvoicePage()));
  }

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

  @override
  Widget build(BuildContext context) {
    // CALCULATE ALL TOTAL
    allTotal = widget.selectedItems.fold(0.0, (sum, item) {
      double price = double.tryParse(item.PriceM) ?? 0.0;
      double total = price * item.QuantityM;
      return sum + total;
    });
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: AppColor.safeArea,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.scaffold,
            appBar: AppBar(
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
                            color: AppColor.white,
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
                                            color: Color.fromARGB(255, 235, 177, 2),
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
      IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColor.scaffold,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  height: 600,
                  width: 400,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 230.0, top: 10),
                        child: Text(
                          'Select Items',
                          style: GoogleFonts.arvo(
                            textStyle: TextStyle(
                              color: AppColor.itemName,
                              fontSize: 15,
                              letterSpacing: -1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SearchBar(
                          leading: Icon(Linecons.search),
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              _searchKeyword.value = value;
                            });
                          },
                          hintText: 'Search Item Here...',
                        ),
                      ),
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
                                    vertical: 0.0, horizontal: 5
                                  ),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              children: [
                Text(
                  'count = ',
                  style: GoogleFonts.robotoSlab(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 162, 154, 154),
                      fontSize: 15,
                      letterSpacing: -1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
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

      // New widget added below the existing content
      
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Center(
          child: Row(
            children: [

              // COUNT --

              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),                  color: AppColor.textFormBorder,
             ),
            child: IconButton(
             onPressed: (){
               if (quantity > 0)
              {
               _updateQuantity(index, -1);
              }
             },
             icon:Icon(
              FontAwesome5.minus,
              color: AppColor.white,
              size: 15,
              ),
              ),
              ),
SizedBox(width: 5,),
              // COUNT TEXT FIELD

              Container(
                width: 50,
                height: 35,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.textFormBorder,
          ),
          child: Center(
            child: TextFormField(
             inputFormatters: [
                                      LengthLimitingTextInputFormatter(3),
                                    ],
                                    style: GoogleFonts.robotoSlab(
                                      color: AppColor.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    controller: _countControllers[index] ??= TextEditingController(text: '0'),

                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(bottom: 10),
                                    ),
                                    onChanged: (value) {
                                      int newValue = int.tryParse(value) ?? 0;
                                      if (newValue > maxCount) {
                                        controller?.text = maxCount.toString();
                                      } else {
                                        setState(() {
                                          _quantities[index] = newValue;
                                        });
                                      }
                                    },
            ),
          ),
              ),
SizedBox(width: 5,),
              // COUNT ++

              Container(
                width: 35,
                height: 35,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.textFormBorder,
              ),
              child:IconButton(
                                  icon: Icon(
                                    FontAwesome5.plus,
                                    color: AppColor.white,
                                    size: 15,
                                  ),
                                  onPressed: () {
                                    _updateQuantity(index, 1);
                                  },
                                ) ,
              ),
            ],
          )
        ),
      ),
    ],
  ),
)

                                    ),
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
            },
          );
        },
        icon: Icon(
          FontAwesome.plus,
          size: 30,
          color: AppColor.lGreenAc,
        ),
      )
    ],
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
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(right: 85.0, bottom: 4.0),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: BottomAppBar(
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
                          size: 32,
                        ),
                        color: AppColor.white,
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
                        color: AppColor.white,
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
                        color: AppColor.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
