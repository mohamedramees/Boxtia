import 'dart:io';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Add_Item.dart';
import 'package:boxtia_inventory/Screens/Product_Page.dart';
import 'package:boxtia_inventory/Screens/Sales_Page.dart';
import 'package:boxtia_inventory/Screens/Stock_Page.dart';
import 'package:boxtia_inventory/Screens/Profile_Page.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key, required});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  String _businessName = '';

  @override
  void initState() {
    super.initState();

    _fetchBusinessName();
  }

  void _fetchBusinessName() async {
    final box = await Hive.openBox<userModel>('boxtiadb');
    List<userModel> users = box.values.toList();
    if (users.isNotEmpty) {
      setState(() {
        _businessName = users[0].bussinessName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //GRID IMAGE

    final List<Image> GImage = [
      Image.asset('lib/asset/sale.png'),
      Image.asset('lib/asset/stock,home.png'),
      Image.asset('lib/asset/add sale.png'),
      Image.asset('lib/asset/TodaySale.png'),
      Image.asset('lib/asset/todayPurchase1.png'),
      Image.asset('lib/asset/outof stock.webp'),
    ];

    //GRID TEXT

    final List<String> GText = [
      "Mothly\n  Sales",
      "Total\nStock",
      " Add\nSales",
      "Today\n Sales",
      "Purchase\n   Report",
      "Out Of\n Stock"
    ];

    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Container(
        color:AppColor.safeArea,
        child: SafeArea(
          child: Scaffold(
            backgroundColor:AppColor.scaffold
,
            //APP BAR
            appBar: AppBar(
              shadowColor: Colors.transparent,
              elevation: 10,
              backgroundColor: AppColor.appBar,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Text(
                  _businessName.isNotEmpty ? _businessName : "BOXTIA",
                  style: GoogleFonts.goldman(
                    textStyle: const TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 25,
                        letterSpacing: -1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              actions: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //ALERT
                    IconButton(
                      onPressed: () {
                        _showLogoutDialog();
                      },
                      icon: Icon(
                        MfgLabs.logout,
                        color: Colors.white,
                      ),
                    ),
                    //PAGE NAME
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        "HOME",
                        style: GoogleFonts.mogra(
                          textStyle: const TextStyle(
                              decorationColor: Colors.tealAccent,
                              color: Colors.white,
                              fontSize: 20,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              toolbarHeight: 85,
            ),
            //BODY & GRID
            body: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8, top: 52),
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      homeGridNavigation(index);
                    },
                    child: Card(
                      
                      color: Color.fromARGB(255, 173, 228, 253),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('lib/asset/gridbackground.jpg'),
                        fit: BoxFit.cover)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //GRID IMAGE
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25.0,),
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Container(
                                        
                                        child: GImage[index]),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                //GRID TEXT
                                SizedBox(
                                  child: Center(
                                    child: Text(
                                      GText[index],
                                      // textAlign: TextAlign.center,
                                      style: GoogleFonts.arvo(
                                        textStyle: const TextStyle(
                                            color: Color.fromARGB(255, 9, 169, 243),
                                            fontSize: 16,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            //FLOATING BUTTON
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 76.0),
              child: FloatingActionButton(
                tooltip: 'add item',
                splashColor: Colors.lightBlueAccent,
                elevation: 20,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddItem()),
                  );
                },
                child: Icon(
                  MfgLabs.plus,
                  size: 25,
                ),
                backgroundColor: AppColor.floating
              ),
            ),

            //BOTTOM APP BAR

            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(right: 85.0, bottom: 4.0),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: BottomAppBar(
                  shadowColor: Colors.transparent,
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 10.0,
                  color: AppColor.bottomBar,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        tooltip: 'profile',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Profile_Page(),
                            ),
                          );
                        },
                        icon: Icon(
                          Typicons.user_outline,
                          size: 32, // Reduced size
                        ),
                        color: Colors.white,
                      ),
                      IconButton(
                        tooltip: 'stock',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Stock_Page()));
                        },
                        icon: Icon(
                          FontAwesome5.boxes,
                          size: 30,
                        ),
                        color: Colors.white,
                      ),
                      IconButton(
                        tooltip: 'product',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Product_Page()));
                        },
                        icon: Icon(
                          Zocial.paypal,
                          size: 30, // Reduced size
                        ),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  //SHOW ALERT

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: 600, // set the maximum width of the dialog
                maxHeight: 430 // set the maximum height of the dialog
                ),
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

  // GRID NAVIGATION

  void homeGridNavigation(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Stock_Page()),
        );
        break;
      case 2:
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => SalesPage()));
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
      case 6:
        break;
      default:
        break;
    }
  }
}
