import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Featurs/FloatingButton.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class DisplayImageScreen extends StatefulWidget {
  final List<invoiceModel> invoiceModels;


  DisplayImageScreen({required this.invoiceModels});

  @override
  State<DisplayImageScreen> createState() => _DisplayImageScreenState();
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  bool _isAscending = true;


//^ SORT ITEMS

  void _sortItems(int sortOption) {
    setState(() {
      _isAscending = sortOption == 1;
      widget.invoiceModels.sort((a, b) {
        int result = a.invoicedateTimeM.compareTo(b.invoicedateTimeM);
        return _isAscending ? result : -result;
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final timeFormat = DateFormat('h:mm a');
  final currencyFormat = NumberFormat('#,###.00', 'en_US');

    return Stack(
      children: [
//^ Background Image
        Positioned.fill(
          child: Image.asset(
            'lib/asset/ScaffoldImage9.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.scaffold,
//^ APPBAR
            appBar: appBarSalesReport(_sortItems),
//^ BODY
            body: ListView.builder(
                itemCount: widget.invoiceModels.length,
                itemBuilder: (context, index) {
                  final invoice = widget.invoiceModels[index];
      final formattedTotal = currencyFormat.format(invoice.InvoiceTotalAmountM);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 5),
                    child: ExpansionTile(
                      collapsedBackgroundColor: AppColor.collapsedBackgroundColor,

                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${index + 1}', style: TextStyle(fontWeight: FontWeight.bold,
                          color: AppColor.darkBlue)),
                          Text(
                            'Date: ${dateFormat.format(invoice.invoicedateTimeM)}',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Time: ${timeFormat.format(invoice.invoicedateTimeM)}',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      subtitle: Text('\u{20B9}$formattedTotal',
                      style: GoogleFonts.arvo(
                          textStyle: const TextStyle(
                            color: AppColor.reportListAmount,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      children: [
                        Image.file(File(invoice.invoiceM))
                        ],
                    ),
                  );
                }),

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
                child: bottomNavBar(context, 'DisplayImage'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
