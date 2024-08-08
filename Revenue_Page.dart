
import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Featurs/FloatingButton.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class RevenuePage extends StatefulWidget {
  const RevenuePage({super.key});

  @override
  State<RevenuePage> createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  //
  double _purchaseAmount = 0;
  double _saleAmount = 0;
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
    _fetchPurchaseAmount();
    _fetchSalesAmount();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat = NumberFormat('#,###.00', 'en_US');
    String formattedPurchaseAmount = currencyFormat.format(_purchaseAmount);
    String formattedSalesAmount = currencyFormat.format(_saleAmount);

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
          appBar: appBars('REVENUE'),
          //^ BODY

          body: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
                height: 300,
                child: Column(
                  children: [
                    Text('Total Purchase Amount:'),
                    Text(
                      '\u{20B9}$formattedPurchaseAmount',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                     Text('Total Sales Amount:'),
                    Text(
                      '\u{20B9}$formattedSalesAmount',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
                // buildLineChart(isShowingMainData)

                ),
          ),

          //^ FLOATING BUTTON
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 76.0),
            child: floatingToHome(context),
          ),
//^ BOTTOM NAV BAR
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
        ))
      ],
    );
  }
}
