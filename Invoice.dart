import 'package:boxtia_inventory/Featurs/Alert.dart';
import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Featurs/Date_Time.dart';
import 'package:boxtia_inventory/Featurs/FloatingButton.dart';
import 'package:boxtia_inventory/Featurs/InvoicePage_Function.dart';
import 'package:boxtia_inventory/Featurs/Si_Number.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoicePage extends StatefulWidget {
  final customerModel customer;
  final List<itemModel> selectedItems;

  const InvoicePage({
    super.key,
    required this.customer,
    required this.selectedItems,
  });

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late customerModel _customer;
  GlobalKey _containerKey = GlobalKey();
  List<String> _imagePaths = [];
  double allTotal = 0.0;

  var imagePath;

  //^ INIT STATE
  @override
  void initState() {
    super.initState();
    _customer = widget.customer;
  }

  //^ HEART ICON
  Icon buildIcon() {
    return Icon(
      RpgAwesome.bleeding_hearts,
      color: AppColor.black,
      size: 35,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ^CALCULATE ALL TOTAL

// Calculate the total amount with profit
    double totalWithProfit = widget.selectedItems.fold(0.0, (sum, item) {
          double price = double.tryParse(item.PriceM) ?? 0.0;
          double total = price * item.QuantityM;
          return sum + total;
        }) *
        1.10; // Adding 10% profit

// Format the total to two decimal places
    String formattedTotal = totalWithProfit.toStringAsFixed(2);

// Parse the formatted string back to double
    double allTotal = double.parse(formattedTotal);

    return Stack(
      children: [
        //^ BACKGROUND IMAGE
        Positioned.fill(
          child: Image.asset(
            'lib/asset/6.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.scaffold,
            //^ APP BAR
            appBar: appBars("INVOICE"),
            //^ BODY
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //^ INVOICE CONTAINER
                  buildInvoiceWidget(
                    containerKey: _containerKey,
                    selectedItems: widget.selectedItems,
                    customer: _customer,
                    SiNumber: SiNumber(),
                    invoiceDateAndTime: invoiceDateAndTime(),
                    allTotal: allTotal,
                  ),
                  //^ SAVE BUTTON
                  OutlinedButton(
                    onPressed: () {
                      shareInvoice(context, _containerKey, _imagePaths, allTotal);
                      // captureAndSaveImage(_containerKey, context, _imagePaths,allTotal);
                    },
                    child: Text(
                      'SAVE',
                      style: GoogleFonts.arvo(
                        textStyle: const TextStyle(
                          color: AppColor.darkBlue,
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(395, 60),
                      side: BorderSide(
                        color: AppColor.darkBlue,
                        width: 4,
                      ),
                      backgroundColor: AppColor.scaffold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //^ FLOATING BUTTON
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 76.0),
              child: floatingToHome(context),
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
                child: bottomNavBar(context, 'invoice'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
