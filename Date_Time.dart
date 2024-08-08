
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

//^ APP BAR DATE AND TIME

Text appBardateAndTime() {
  DateTime now = DateTime.now();

  String formattedDate = DateFormat('d-M-y').format(now);

  return Text('$formattedDate',
  style: GoogleFonts.notoSerif(
              textStyle: const TextStyle(
                color: AppColor.white,
                fontSize: 13,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
              ),
  )
  );
}

//^ INVOICE DATE AND TIME

Text invoiceDateAndTime() {
  DateTime now = DateTime.now();

  String formattedDate = DateFormat('EEE, d, MMM, yyyy').format(now);

  return Text('$formattedDate',
  style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: AppColor.black,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
  )
  );
}
