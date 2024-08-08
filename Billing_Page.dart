import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/BillPage_Function.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Functions/DB_Functions.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Home_Page.dart';
import 'package:boxtia_inventory/Screens/Invoice.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({
    super.key,
    required List<itemModel> selectedItems,
  });

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerNumberController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  // ignore: unused_field
  ValueNotifier<String> _selectedCategory = ValueNotifier<String>('All');
  ValueNotifier<String> _searchKeyword = ValueNotifier<String>('');
  String search = 'Search Item Here...';
  List<itemModel> _items = [];
  List<itemModel> _selectedItems = [];

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

  //^ INISTATE
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

  //^ FETCH ITEMS (COUNT > 0)
  void _fetchItems() async {
    final box = await Hive.openBox<itemModel>('boxtiaitemdb');
    List<itemModel> items = box.values.toList();
    List<itemModel> filteredItems = items.where((item) {
      int? countM = int.tryParse(item.CountM);
      return countM != null && countM > 0;
    }).toList();

    setState(() {
      _items = filteredItems;
      for (int i = 0; i < _items.length; i++) {
        _countControllers[i] = TextEditingController(text: '0');
        _quantities[i] = 0;
      }
    });
  }

  //^ BILL REGISTRATION
  Future<void> _registerBill(BuildContext context, List<itemModel> selectedItems, double allTotal) async {
    String _CustomerName = _customerNameController.text;
    String _CustomerNumber = _customerNumberController.text;

    customerModel saveCustomer = customerModel(
      customerNameM: _CustomerName,
      customerNumberM: _CustomerNumber,
      selectedItemsM: selectedItems,
      sellTotalM: allTotal,
    );

    await addCustomerF(saveCustomer);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvoicePage(
          customer: saveCustomer,
          selectedItems: selectedItems,
        ),
      ),
    );
  }

  void _dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  //^ UPDATE ITEM
  void _updateSelectedItems(List<itemModel> selectedItems) {
    FocusScope.of(context).unfocus();
    setState(() {
      _selectedItems = selectedItems;
    });
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
      _selectedItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // ^CALCULATE ALL TOTAL
    // Calculate the total amount with profit
    double totalWithProfit = _selectedItems.fold(0.0, (sum, item) {
          double price = double.tryParse(item.PriceM) ?? 0.0;
          double total = price * item.QuantityM;
          return sum + total;
        }) *
        1.10; // Adding 10% profit

    // Format the total to two decimal places
    String formattedTotal = totalWithProfit.toStringAsFixed(2);

    // Parse the formatted string back to double
    double allTotal = double.parse(formattedTotal);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home_Page()),
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
                      //^ LIST VIEW BUILDER
                      buildItemList(_selectedItems, deleteBillingItem),

                      //^ TOTAL PRICE
                      buildTotalRow(allTotal),

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
                                color: AppColor.darkBlue, fontSize: 15, letterSpacing: -1, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      //^ CUSTOMER NAME
                      buildCustomerField(
                        controller: _customerNameController,
                        focusNode: _focusNodeName,
                        isFocused: _isFocusedName,
                        onClear: _clearCname,
                        labelText: 'Enter Customer Name Here',
                        keyboardType: TextInputType.name,
                        inputFormatters: [LengthLimitingTextInputFormatter(12)],
                        textColor: AppColor.darkBlue,
                      ),

                      //^ CUSTOMER NUMBER
                      buildCustomerField(
                        controller: _customerNumberController,
                        focusNode: _focusNodeNumber,
                        isFocused: _isFocusedNumber,
                        onClear: _clearCnumber,
                        labelText: 'Enter Customer Number Here',
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        textColor: AppColor.white,
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
                                  color: AppColor.darkBlue,
                                  fontSize: 15,
                                  letterSpacing: -1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            //^ BOTTM SHEET
                            IconButton(
                              onPressed: () {
                                showItemSelectionBottomSheet(
                                  context: context,
                                  items: _items,
                                  quantities: _quantities,
                                  updateQuantity: _updateQuantity,
                                  searchController: _searchController,
                                  searchKeyword: _searchKeyword,
                                  updateSelectedItems: _updateSelectedItems,
                                  countControllers: _countControllers,
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
                      _dismissKeyboard();
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
                              purchaseAmountM: '');
                          selectedItems.add(selectedItem);
                        }
                      });
                      //^ REGISTER CUSTOMER
                      _registerBill(context, _selectedItems, allTotal);
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
                    backgroundColor: AppColor.darkBlue,
                  ),
                ),
                //^ NAVIGATION BAR
                 bottomNavigationBar: Padding(
                  padding: const EdgeInsets.only(right: 85.0, bottom: 4.0),
                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: bottomNavBar(context, 'billingPage'),
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

// onPressed: () async {
//                     await _registerBill(context, _selectedItems, allTotal);
//                   },
