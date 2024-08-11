import 'dart:io';
import 'package:boxtia_inventory/Featurs/Bill_Image.dart';
import 'package:boxtia_inventory/Featurs/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

//^ LONGOUT ALERT

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          constraints: BoxConstraints(maxWidth: 600, maxHeight: 430),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'lib/asset/goodbye2.png',
                    width: 130,
                  ),
                  Text(
                    'See You Soon!',
                    style: GoogleFonts.gorditas(
                      textStyle: const TextStyle(
                          color: Color.fromRGBO(145, 39, 64, 1),
                          fontSize: 30,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'You are about to Logout.\n Are you sure this is\n What you want?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.gorditas(
                      textStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.gorditas(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(145, 39, 64, 1),
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                            Color.fromRGBO(145, 39, 64, 1),
                          )),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            exit(0);
                          },
                          child: Text(
                            'Confirm',
                            style: GoogleFonts.gorditas(
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

//^ DELETE ALERT FOR BILLING PAGE

void deleteAlertBilling(BuildContext context, int index, Function(int) deleteBillingItem) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Confirm !!',
          style: GoogleFonts.sahitya(
            textStyle: TextStyle(color: Colors.redAccent[400], fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        content: Text(
          'Are you sure you want to delete this item?',
          textAlign: TextAlign.start,
          style: GoogleFonts.sahitya(
            textStyle: TextStyle(color: Colors.grey[700], fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: GoogleFonts.gorditas(fontSize: 14, color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(
            width: 100,
            height: 40,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                Colors.redAccent[400],
              )),
              onPressed: () {
                Navigator.of(context).pop();
                deleteBillingItem(index);
              },
              child: Text(
                'Delete',
                style: GoogleFonts.gorditas(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

//^ DELETE ALERT FOR PRODUCT

void deleteItemProduct(BuildContext context, int index, Function(int) deleteItem) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Confirm !!',
          style: GoogleFonts.sahitya(
            textStyle: TextStyle(color: Colors.redAccent[400], fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        content: Text(
          'Are you sure you want to delete this item?',
          textAlign: TextAlign.start,
          style: GoogleFonts.sahitya(
            textStyle: TextStyle(color: Colors.grey[700], fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: GoogleFonts.gorditas(fontSize: 14, color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(
            width: 100,
            height: 40,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                Colors.redAccent[400],
              )),
              onPressed: () {
                Navigator.of(context).pop();
                deleteItem(index);
              },
              child: Text(
                'Delete',
                style: GoogleFonts.gorditas(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

// //^ SHARE ALERT FOR INVOICE
Future<void> shareInvoice(
    BuildContext context, GlobalKey containerKey, List<String> imagePaths, double allTotal) async {
  // Capture and save the image first
  await captureAndSaveImage(containerKey, context, imagePaths, allTotal);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'SHARE',
          style: GoogleFonts.sahitya(
            textStyle: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        content: Text(
          'You Want To Share This Invoice...',
          textAlign: TextAlign.start,
          style: GoogleFonts.sahitya(
            textStyle: TextStyle(color: Colors.grey[700], fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: GoogleFonts.gorditas(fontSize: 14, color: Colors.black),
            ),
            onPressed: () {
              navigationSalesReport(context);
            },
          ),
          SizedBox(
            width: 100,
            height: 40,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () async {
                if (imagePaths.isNotEmpty) {
                  final lastImagePath = imagePaths.last;
                  await shareInvoiceImage(lastImagePath);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text('No image to share'),
                  ));
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Share',
                style: GoogleFonts.gorditas(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> shareInvoiceImage(String imagePath) async {
  try {
    final File imageFile = File(imagePath);
    if (await imageFile.exists()) {
      await Share.shareFiles([imagePath]);
    } else {
      throw Exception('Image file does not exist.');
    }
  } catch (e) {
    print('Error sharing image: $e');
  }
}
