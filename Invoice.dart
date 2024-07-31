import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Featurs/FloatingButton.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {

  List<customerModel> _customer = [];

  @override
  void initState() {
    super.initState();

    _fetchCustomer();
  }



  //FETCH CUTOMER

  void _fetchCustomer() async {
    final box = await Hive.openBox<customerModel>('boxtiacustomerdb');
    List<customerModel> customer = box.values.toList();
    setState(() {
      _customer = customer;
    });
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

//^ BODY

            body: Column(
              children: _customer.isNotEmpty
                  ? _customer.map((customer) => Text(customer.customerNameM)).toList()
                  : [Text('No customers found')],

            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 76.0),
              child: floatingToHome(context),
            ),
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
