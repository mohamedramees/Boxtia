
import 'dart:io';

import 'package:boxtia_inventory/Featurs/Alert.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

//* MAIN LIST IN BILLING PAGE

Widget buildItemList(List<itemModel> selectedItems, Function(int) deleteBillingItem) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: selectedItems.length,
      itemBuilder: (context, index) {
        final item = selectedItems[index];

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
                      fontSize: 22,
                    ),
                  ),
                ),
                //^ DELETE BUTTON
                IconButton(
                  onPressed: () {
                    deleteAlertBilling(context, index, deleteBillingItem);
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
                          fontSize: 13,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    //^ ITEM QUANTITY
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
                    SizedBox(width: 30),
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
  );
}


//* TOTAL AMOUNT IN BILLING PAGE

Widget buildTotalRow(double allTotal) {

  // Create a NumberFormat instance for formatting with commas
  final NumberFormat formatter = NumberFormat('#,##,###.00');

  // Format allTotal for display
  String formattedAllTotal = formatter.format(allTotal);

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Total + 10%  : \u{20B9} ',
        style: GoogleFonts.arvo(
          textStyle: const TextStyle(
            color: AppColor.darkBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Text(
        formattedAllTotal,
        style: GoogleFonts.arvo(
          textStyle: const TextStyle(
            color: AppColor.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}


//* CUSTOMER TEXT FIELD

Padding buildCustomerField({
  required TextEditingController controller,
  required FocusNode focusNode,
  required bool isFocused,
  required VoidCallback onClear,
  required String labelText,
  required TextInputType keyboardType,
  required List<TextInputFormatter> inputFormatters,
  required Color textColor,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextFormField(
      focusNode: focusNode,
      style: TextStyle(
        color: textColor,
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColor.darkBlue)),
        labelText: labelText,
        suffixIcon: isFocused
            ? IconButton(
                onPressed: onClear,
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
  );
}

//* BOTTOM SHEET IN BILLING PAGE

void showItemSelectionBottomSheet({
  required BuildContext context,
  required List<itemModel> items,
  required Map<int, int> quantities,
  required Function(int, int) updateQuantity,
  required TextEditingController searchController,
  required ValueNotifier<String> searchKeyword,
  required Function(List<itemModel>) updateSelectedItems,
  required Map<int, TextEditingController?> countControllers,
}) {
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
                    padding: const EdgeInsets.only(left: 275.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_downward, // Use a different icon here
                            color: AppColor.white,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            List<itemModel> selectedItems = [];
                            quantities.forEach((index, quantity) {
                              if (quantity > 0) {
                                final updatedItem = items[index];
                                final selectedItem = itemModel(
                                  ItemNameM: updatedItem.ItemNameM,
                                  PriceM: updatedItem.PriceM,
                                  CountM: updatedItem.CountM,
                                  ItemPicM: updatedItem.ItemPicM,
                                  CategoryM: updatedItem.CategoryM,
                                  ColorM: updatedItem.ColorM,
                                  BrandM: updatedItem.BrandM,
                                  QuantityM: quantity,
                                  purchaseAmountM: '',
                                );
                                selectedItems.add(selectedItem);
                              }
                            });
                            updateSelectedItems(selectedItems); // Update the main list
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 230.0, top: 10),
                    child: Padding(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        searchKeyword.value = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Item Here...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear, color: Colors.black),
                                onPressed: () {
                                  searchController.clear();
                                  searchKeyword.value = '';
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder<String>(
                      valueListenable: searchKeyword,
                      builder: (context, searchKeyword, child) {
                        List<itemModel> filteredItems = items
                            .where((item) => item.ItemNameM.toLowerCase().contains(searchKeyword.toLowerCase()))
                            .toList();
                        return ListView.builder(
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];
                            final originalIndex = items.indexOf(item);
                            final quantity = quantities[originalIndex] ?? 0;
                            var controller = countControllers[originalIndex];
                            int maxCount = int.parse(item.CountM);

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5),
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
                                          color: AppColor.darkBlue,
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
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: AppColor.darkBlue,
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      if (quantity > 0) {
                                                        updateQuantity(originalIndex, -1);
                                                      }
                                                    },
                                                    icon: Icon(
                                                      FontAwesome.minus,
                                                      color: AppColor.white,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  width: 50,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: AppColor.darkBlue,
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
                                                      controller: controller ??= TextEditingController(text: '0'),
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
                                                          quantities[originalIndex] = newValue;
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: AppColor.darkBlue,
                                                  ),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      FontAwesome.plus,
                                                      color: AppColor.white,
                                                      size: 15,
                                                    ),
                                                    onPressed: () {
                                                      updateQuantity(originalIndex, 1);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
  );
}
