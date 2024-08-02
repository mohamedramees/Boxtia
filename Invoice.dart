import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Featurs/Date_Time.dart';
import 'package:boxtia_inventory/Featurs/FloatingButton.dart';
import 'package:boxtia_inventory/Featurs/Si_Number.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class InvoicePage extends StatefulWidget {
  final customerModel customer;


  const InvoicePage({
    super.key,
    required this.customer,
  });

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late customerModel _customer;
  List<itemModel> _items = [];

//^INISTATE

  @override
  void initState() {
    super.initState();
    _customer = widget.customer;
    _fetchItems();
  }
  void _fetchItems() async {
    final box = await Hive.openBox<itemModel>('boxtiaitemdb');
    List<itemModel> items = box.values.toList();
    setState(() {
      _items = items;

    });
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
    return Stack(
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

//^ APP BAR

            appBar: appBars("INVOICE"),

//^BODY

            body: SingleChildScrollView(
              child: Column(
                children: [
//^ MESSAGE

                  // Center(
                  //   child: Container(
                  //     padding: const EdgeInsets.all(15.0),
                  //     child: RichText(
                  //       textAlign: TextAlign.center,
                  //       text: TextSpan(
                  //         children: [
                  //           TextSpan(
                  //             text: 'Thank you for choosing\n to collaborate with \n us ',
                  //             style: GoogleFonts.eduVicWaNtBeginner(
                  //               textStyle: TextStyle(
                  //                 color: AppColor.black,
                  //                 fontSize: 35,
                  //                 letterSpacing: -1,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //           ),
                  //           WidgetSpan(
                  //             child: Padding(
                  //               padding: const EdgeInsets.only(left: 5.0),
                  //               child: buildIcon(),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

//^ INVOICE CONTAINER

                  SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 395,
                          height: 690,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8), color: Color.fromARGB(194, 255, 255, 255)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10, left: 10),

                        //^ INVOICE TEXT

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
                        //^ INVOICE ID

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
                        //^ SERIAL NUMBER
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                          SiNumber(),
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
                        //^BILL DATE
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
                        //^ INVOICE DATE
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: SizedBox(
                                        child: invoiceDateAndTime(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, top: 30),
                                child: Column(
                                  children: [
                        //^BILL TO
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
                        //^ NAME
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
                        //^ CUSTOMER NAME
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10.0),
                                          child: Text(
                                            _customer.customerNameM,
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
                        //^ MOB
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
                        //^ CUSTOMER NUMBER
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10.0),
                                          child: Text(
                                            _customer.customerNumberM,
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

                              //^ DOTTED LINE 1ST

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                child: DottedLine(
                                  dashColor: Color.fromARGB(255, 118, 118, 118),
                                )
                              ),
//^ ITEMS TEXT
                              Padding(
                                padding: const EdgeInsets.only( left: 10),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
//^ AMOUNT TEXT
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5.0),
                                      child: Text('AMOUNT',
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
                        SizedBox(height: 10,),
                                Expanded(
                                  child: ListView.builder(
                                  itemCount: _items.length,
                                  itemBuilder: (context, index) {
                                    final item = _items[index];
//^ PRICE AND QUANTITY CALCULATION

                            double price = double.tryParse(item.PriceM) ?? 0.0;
                            double total = price * item.QuantityM;
                                    return ListTile(
                         contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 10 ),

                                tileColor: Color.fromARGB(155, 255, 255, 255),
                                      leading: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
//^ ITEM NAME
                                          Text(item.ItemNameM,
                                          style: GoogleFonts.arvo(
                                          textStyle: const TextStyle(
                                            color: AppColor.black,
                                            fontSize: 15,
                                            letterSpacing: -.8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                                                              ),
                                                                              ),
//^ ITEM PRICE X ITEM COUNT TEXT
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
//^ ITEM TOTAL AMOUNT
                                    trailing:Text(
                                      '\u{20B9}$total',
                                       style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                        color: AppColor.black,
                                        fontSize: 15,
                                        letterSpacing: -.8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ) ,
                                    );
                                  }),
                                ),
//^ DOTTED LINE 2ND

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                child: DottedLine(
                                  dashColor: Color.fromARGB(255, 118, 118, 118),
                                )
                              ),
//^ TOTAL TEXT
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0,bottom: 20),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'TOTAL',
                                     style: GoogleFonts.arvo(
                                              textStyle: const TextStyle(
                                                color: AppColor.black,
                                                fontSize: 18,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                    Text('\u{20B9}0000.00',
                                     style: GoogleFonts.arvo(
                                              textStyle: const TextStyle(
                                                color: AppColor.black,
                                                fontSize: 18,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
                child: bottomNavBar(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
