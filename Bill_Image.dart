import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


Future<void> captureAndSaveImage(
    GlobalKey containerKey, BuildContext context, List<String> imagePaths, double allTotal) async {
  try {
    RenderRepaintBoundary boundary = containerKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final path = '${directory.path}/container_image_$timestamp.png';
      final file = File(path);
      await file.writeAsBytes(pngBytes);
      imagePaths.add(path);

      await addImageToInvoiceDatabase(path, allTotal);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Image saved'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Failed to capture image'),
      ));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      content: Text('Error: $e'),
    ));
  }
}

Future<void> addImageToInvoiceDatabase(String imagePath, double allTotal) async {
  final box = await Hive.openBox<invoiceModel>('invoices');
  final invoice = invoiceModel(
    invoiceM: imagePath,
    invoicedateTimeM: DateTime.now(),
    InvoiceTotalAmountM: allTotal,
  );
  await box.add(invoice);
}

Future<List<invoiceModel>> fetchInvoiceModels() async {
  final box = await Hive.openBox<invoiceModel>('invoices');
  return box.values.toList();
}




