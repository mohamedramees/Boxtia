import 'dart:io';
import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Featurs/FloatingButton.dart';
import 'package:boxtia_inventory/Featurs/Navigation.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key, required});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  void initState() {
    super.initState();
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
      child: Stack(children: [
//^ BACKGROUND IMAGE
        Positioned.fill(
          child: Image.asset(
            'lib/asset/ScaffoldImage9.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,

//^ APP BAR

            appBar: appBarHome("HOME", context),

//^ BODY & GRID
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
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('lib/asset/gridbackground.jpg'), fit: BoxFit.cover)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
//^ GRID IMAGE
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 25.0,
                                    ),
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Container(child: GImage[index]),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
//^ GRID TEXT
                                SizedBox(
                                  child: Center(
                                    child: Text(
                                      GText[index],

                                      style: GoogleFonts.arvo(
                                        textStyle: const TextStyle(
                                            color: AppColor.darkBlue,
                                            fontSize: 17,
                                            letterSpacing: -.5,
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

//^ FLOATING BUTTON
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 76.0),
              child: floatingAddItemButton(context),
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
      ]),
    );
  }

  // GRID NAVIGATION

  void homeGridNavigation(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        navigationStock(context);
        break;
      case 2:
        navigationSales(context);
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
      navigationOutOfStock(context);
        break;
      default:
        break;
    }
  }
}
