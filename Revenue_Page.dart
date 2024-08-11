import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Featurs/FloatingButton.dart';
import 'package:boxtia_inventory/Featurs/Revenue_Functions.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class RevenuePage extends StatefulWidget {
  const RevenuePage({super.key});

  @override
  State<RevenuePage> createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  double _purchaseAmount = 0;
  double _saleAmount = 0;
  double _profitAmount = 0;
  late bool isShowingMainData;
  late List<invoiceModel> _invoices = [];
  double cumulativeProfit = 0.0;

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
    _fetchPurchaseAmount();
    _fetchSalesAmount();
     _fetchAndGroupProfitByDate();
    _printInvoiceData();
  }

  void _printInvoiceData() async {
    final box = await Hive.openBox<invoiceModel>('boxtiainvoicedb');
    List<invoiceModel> invoices = box.values.toList();

    for (var invoice in invoices) {
      print('Invoice: ${invoice.invoiceM}, Date: ${invoice.invoicedateTimeM}');
    }
  }

//^ FETCH INVOICE DATA AND SORT BY DATE
 void _fetchAndGroupProfitByDate() async {
    final box = await Hive.openBox<invoiceModel>('boxtiainvoicedb');
    List<invoiceModel> invoices = box.values.toList();

    Map<String, List<invoiceModel>> groupedInvoices = {};

    for (var invoice in invoices) {
      if ((startDate == null || invoice.invoicedateTimeM.isAfter(startDate!)) &&
          (endDate == null || invoice.invoicedateTimeM.isBefore(endDate!))) {
        String dateKey = DateFormat('dd MMM yyyy').format(invoice.invoicedateTimeM);

        cumulativeProfit += invoice.ProfitM;

        if (groupedInvoices.containsKey(dateKey)) {
          groupedInvoices[dateKey]?.add(invoice);
        } else {
          groupedInvoices[dateKey] = [invoice];
        }
      }
    }

    setState(() {
      _invoices = groupedInvoices.entries
          .map((entry) => invoiceModel(
                invoiceM: entry.value.length.toString(), // Store the count of invoices for the date
                invoicedateTimeM: DateFormat('dd MMM yyyy').parse(entry.key),
                InvoiceTotalAmountM: 0, // or any placeholder data
                ProfitM: entry.value.fold(0.0, (sum, invoice) => sum + invoice.ProfitM), // Sum of profits for the date
              ))
          .toList();
      print('Grouped profits by date: ${_invoices.length}');
    });
  }







  //^ FETCH PURCHASE AMOUNT
  void _fetchPurchaseAmount() async {
    final box = await Hive.openBox<itemModel>('boxtiaitemdb');
    List<itemModel> items = box.values.toList();

    double totalPurchaseAmount = 0;
    for (var item in items) {
      double purchaseAmount = double.tryParse(item.purchaseAmountM) ?? 0.0;
      totalPurchaseAmount += purchaseAmount;
    }

    setState(() {
      _purchaseAmount = totalPurchaseAmount;
    });
  }

  //^ FETCH SALES AMOUNT
  void _fetchSalesAmount() async {
    final box = await Hive.openBox<customerModel>('boxtiacustomerdb');
    List<customerModel> sales = box.values.toList();

    double totalSalesAmount = 0;
    for (var sale in sales) {
      totalSalesAmount += sale.sellTotalM;
    }

    setState(() {
      _saleAmount = totalSalesAmount;
      _calculateProfit();
    });
  }

  //^ CALCULATE PROFIT
  void _calculateProfit() {
    _profitAmount = _saleAmount * 0.10;
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat = NumberFormat('#,###.00', 'en_US');
    String formattedPurchaseAmount = currencyFormat.format(_purchaseAmount);
    String formattedSalesAmount = currencyFormat.format(_saleAmount);
    String formattedProfitAmount = currencyFormat.format(_profitAmount);

    return Stack(
      children: [
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
            appBar: appBars('REVENUE'),
            //^ BODY
            body: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                       buildAmountCard(
                        'Purchase Amount',
                        formattedPurchaseAmount,
                        Colors.grey[300]!,
                        Colors.white,
                      ),
                      buildAmountCard(
                        'Sales Amount',
                        formattedSalesAmount,
                        Color.fromARGB(207, 255, 255, 255),
                        Colors.amberAccent,
                      ),

                    ],
                  ),
                ),
                //^ PROFIT AMOUNT
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Profit: \u{20B9}$formattedProfitAmount',
                    style: GoogleFonts.arvo(
                      textStyle: TextStyle(
                        color: AppColor.darkBlue,
                        fontSize: 22,
                        letterSpacing: -1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                //^ LIST

               Expanded(
                  child: _invoices.isEmpty
                      ? Center(child: Text('No invoices available'))
                      : ListView.builder(
                          itemCount: _invoices.length,
                          itemBuilder: (context, index) {
                            final invoice = _invoices[index];
                            String formattedDate = DateFormat('dd MMM yyyy').format(invoice.invoicedateTimeM);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.scaffold,
                                    border: Border.all(
                                      color: AppColor.darkBlue,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    tileColor: Colors.transparent,
                                    style: ListTileStyle.list,
                                    title: Text(
                                      'Date:    $formattedDate',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Profit:   \u{20B9}$formattedProfitAmount',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Bill Count: ${invoice.invoiceM}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),

  Padding(
                  padding: const EdgeInsets.only(left: 323.0),
                  child: FloatingActionButton(
                    backgroundColor: AppColor.darkBlue,
                    heroTag: 'DateRange',
                    onPressed: () {
                      showCustomDateRangePicker(
                        context,
                        dismissible: true,
                        minimumDate: DateTime.now().subtract(const Duration(days: 30)),
                        maximumDate: DateTime.now().add(const Duration(days: 30)),
                        endDate: endDate,
                        startDate: startDate,
                        backgroundColor: Colors.white,
                        primaryColor: AppColor.darkBlue,
                        onApplyClick: (start, end) {
                          setState(() {
                            startDate = start;
                            endDate = end;
                          });
                          _fetchAndGroupProfitByDate(); // Refresh data with new date range
                        },
                        onCancelClick: () {
                          setState(() {
                            endDate = null;
                            startDate = null;
                          });
                          _fetchAndGroupProfitByDate(); // Refresh data to show all invoices
                        },
                      );
                    },
                    tooltip: 'Choose Date Range',
                    child: const Icon(Icons.calendar_today_outlined, color: Colors.white),
                  ),
                )



              ],
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
                child: bottomNavBar(context, 'purchase'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
