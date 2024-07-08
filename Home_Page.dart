import 'dart:io';

import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Add_Item.dart';
import 'package:boxtia_inventory/Screens/Product_page.dart';
import 'package:boxtia_inventory/Screens/Stock_Page.dart';
import 'package:boxtia_inventory/Screens/Profile_Page.dart';
import 'package:boxtia_inventory/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkAuth();
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

  Future<void> _checkAuth() async {
    bool authenticated = await _authService.authenticate();
    if (!authenticated) {
      _showAuthFailedDialog();
    }
  }

  void _showAuthFailedDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Authentication Failed'),
        content: Text('Unable to authenticate. The app will close now.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();

              SystemNavigator.pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //GRID IMAGE

    final List<Image> GImage = [
      Image.asset('lib/asset/sale.png'),
      Image.asset('lib/asset/stock,home.png'),
      Image.asset('lib/asset/Add Purchase.png'),
      Image.asset('lib/asset/add sale.png'),
      Image.asset('lib/asset/TodaySale.png'),
      Image.asset('lib/asset/todayPurchase1.png'),
      Image.asset('lib/asset/outof stock.webp'),
    ];

    //IMAGE BRIGHTNESS

    List<Widget> getBrightenedImages(List<Image> images) {
      return images.map((image) {
        return ColorFiltered(
          colorFilter: ColorFilter.matrix(
            <double>[
              1.2,
              0,
              0,
              0,
              0,
              0,
              1.2,
              0,
              0,
              0,
              0,
              0,
              1.2,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
            ],
          ),
          child: image,
        );
      }).toList();
    }

    final List<Widget> brightenedImages = getBrightenedImages(GImage);

    //GRID TEXT

    final List<String> GText = [
      "     Mothly\n   Sales",
      "     Total\n     Stock",
      "Add\n       Purchase",
      "    Add\n      Sales",
      "     Today\n    Sales",
      "Today\n     Purchase",
      "     Out Of\n   Stock"
    ];

    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            elevation: 10,
            backgroundColor: Color.fromARGB(255, 21, 127, 213),
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                _businessName.isNotEmpty ? _businessName : "BOXTIA",
                style: GoogleFonts.mogra(
                  textStyle: const TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 30,
                      letterSpacing: 1,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      "HOME",
                      style: GoogleFonts.mogra(
                        textStyle: const TextStyle(
                            decorationColor: Colors.tealAccent,
                            color: Colors.tealAccent,
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
          body: Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: GridView.builder(
              itemCount: 7,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ClipRRect(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        color: Color.fromARGB(255, 12, 121, 211),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25.0, left: 15),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: brightenedImages[index],
                              ),

                              // Icon(
                              //   GIcon[index],
                              //   size: 35,
                              //   color: Colors.white,
                              // ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              GText[index],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mogra(
                                textStyle: const TextStyle(
                                    color: Colors.tealAccent,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w400),
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
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 76.0),
            child: FloatingActionButton(
              splashColor: Colors.lightBlueAccent,
              elevation: 20,
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Add_Item()),
                // );
              },
              child: Icon(
                MfgLabs.plus,
                size: 25,
              ),
              backgroundColor: Color.fromARGB(255, 21, 127, 213),
            ),
          ),
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
                color: Color.fromARGB(255, 21, 127, 213),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
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
                        // Text(
                        //   'Stock',
                        //   style: GoogleFonts.mogra(
                        //     textStyle: const TextStyle(
                        //       color: Colors.cyanAccent,
                        //       fontSize: 12,
                        //       letterSpacing: 1,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
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
                        // Text(
                        //   'Profile',
                        //   style: GoogleFonts.mogra(
                        //     textStyle: const TextStyle(
                        //       color: Colors.cyanAccent,
                        //       fontSize: 12,
                        //       letterSpacing: 1,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Product_Page()));
                          },
                          icon: Icon(
                            Zocial.paypal,
                            size: 30, // Reduced size
                          ),
                          color: Colors.white,
                        ),
                        // Text(
                        //   'Product',
                        //   style: GoogleFonts.mogra(
                        //     textStyle: const TextStyle(
                        //       color: Colors.cyanAccent,
                        //       fontSize: 12,
                        //       letterSpacing: 1,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
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
                                backgroundColor: MaterialStatePropertyAll(
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
}
