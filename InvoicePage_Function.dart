
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

Widget buildInvoiceWidget({
  required GlobalKey containerKey,
  required List<itemModel> selectedItems,
  required customerModel customer,
  required String SiNumber,
  required Widget invoiceDateAndTime,
  required double allTotal,
}) {
  // Format the allTotal amount with thousand separators
  final NumberFormat currencyFormat = NumberFormat('#,###.00', 'en_US');
  String formattedTotal = currencyFormat.format(allTotal);

  return SingleChildScrollView(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RepaintBoundary(
          key: containerKey,
          child: Container(
            width: 395,
            height: 635,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(173, 255, 255, 255),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    'INVOICE',
                    style: GoogleFonts.arvo(
                      textStyle: const TextStyle(
                        color: AppColor.black,
                        fontSize: 22,
                        letterSpacing: -.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Invoice ID :',
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(
                            color: AppColor.black,
                            fontSize: 15,
                            letterSpacing: -.8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            SiNumber,
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: AppColor.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bill Date :',
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(
                            color: AppColor.black,
                            fontSize: 15,
                            letterSpacing: -.8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: SizedBox(
                          child: invoiceDateAndTime,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 30),
                  child: Column(
                    children: [
                      Text(
                        'Bill To',
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(
                            decorationThickness: 2,
                            decoration: TextDecoration.underline,
                            color: AppColor.black,
                            fontSize: 15,
                            letterSpacing: -.8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              'NAME  :',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  color: AppColor.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              customer.customerNameM,
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  color: AppColor.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'MOB    :',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: AppColor.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              customer.customerNumberM,
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  color: AppColor.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: DottedLine(
                    dashColor: Color.fromARGB(255, 118, 118, 118),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ITEMS',
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                            color: AppColor.black,
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text(
                          'AMOUNT',
                          style: GoogleFonts.arvo(
                            textStyle: const TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 1.5,
                              color: AppColor.black,
                              fontSize: 18,
                              letterSpacing: -2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
//^ INVOICE LIST
                Expanded(
                  child: ListView.builder(
                    itemCount: selectedItems.length,
                    itemBuilder: (context, index) {
                      final item = selectedItems[index];
                      double price = double.tryParse(item.PriceM) ?? 0.0;
                      double total = price * item.QuantityM;
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        tileColor: AppColor.scaffold,
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              item.ItemNameM,
                              style: GoogleFonts.arvo(
                                textStyle: const TextStyle(
                                  color: AppColor.black,
                                  fontSize: 15,
                                  letterSpacing: -.8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '${item.PriceM} x ${item.QuantityM}',
                              style: GoogleFonts.arvo(
                                textStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: Text(
                          '\u{20B9}$total',
                          style: GoogleFonts.arvo(
                            textStyle: const TextStyle(
                              color: AppColor.black,
                              fontSize: 15,
                              letterSpacing: -.8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: DottedLine(
                    dashColor: Color.fromARGB(255, 118, 118, 118),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TOTAL + 10% ',
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(
                            color: AppColor.black,
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          '\u{20B9}$formattedTotal',
                          style: GoogleFonts.arvo(
                            textStyle: TextStyle(
                              color: AppColor.black,
                              fontSize: 18,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    ),
  );
}
