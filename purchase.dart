// import 'package:boxtia_inventory/Model/DB_Model.dart';
// import 'package:boxtia_inventory/Screens/Home_Page.dart';
// import 'package:boxtia_inventory/Screens/Product_Page.dart';
// import 'package:boxtia_inventory/Screens/Profile_Page.dart';
// import 'package:boxtia_inventory/Screens/Stock_Page.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';
// import 'package:fluttericon/octicons_icons.dart';
// import 'package:fluttericon/typicons_icons.dart';
// import 'package:fluttericon/zocial_icons.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive/hive.dart';

// class AddPurchase_Page extends StatefulWidget {
//   AddPurchase_Page({super.key});

//   @override
//   State<AddPurchase_Page> createState() => _AddPurchase_PageState();
// }

// class _AddPurchase_PageState extends State<AddPurchase_Page> {
//   @override
//   void initState() {
//     super.initState();
//     _fetchBusinessName();
//   }

//   String _businessName = '';

//   void _fetchBusinessName() async {
//     final box = await Hive.openBox<userModel>('boxtiadb');
//     List<userModel> users = box.values.toList();
//     if (users.isNotEmpty) {
//       setState(() {
//         _businessName = users[0].bussinessName;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blue,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             shadowColor: Colors.transparent,
//             elevation: 10,
//             backgroundColor: Color.fromARGB(255, 21, 127, 213),
//             automaticallyImplyLeading: false,
//             title: Padding(
//               padding: const EdgeInsets.only(
//                 top: 8.0,
//               ),
//               child: Text(
//                 _businessName.isNotEmpty ? _businessName : "BOXTIA",
//                 style: GoogleFonts.goldman(
//                   textStyle: const TextStyle(
//                       color: Colors.cyanAccent,
//                       fontSize: 25,
//                       letterSpacing: -1,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             actions: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     "PURCHASE ",
//                     style: GoogleFonts.mogra(
//                       textStyle: const TextStyle(
//                           decorationColor: Colors.tealAccent,
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//             toolbarHeight: 85,
//           ),
//           body: GridView.builder(
//             itemCount: 5,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: .8,

//             ),
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   shadowColor: Color.fromARGB(214, 2, 21, 228),
//                   color: Color.fromARGB(218, 255, 255, 255),
//                   child: ClipRRect(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10.0, left: 10,right: 10),
//                           child: SizedBox(
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(15),
//                               child: Image.asset('lib/asset/samsung galaxy s24 Ultra.jpg')),
//                           ),
//                         ),SizedBox(height: 5,),
//                         Text('Galaxy S24',
//                         style: GoogleFonts.robotoSlab(
//                     textStyle: const TextStyle(
//                         color: Colors.blue,
//                         fontSize: 18,
//                         letterSpacing: -1,
//                         fontWeight: FontWeight.bold),
//                   ),
//                         ),

//                         Text('\u{20B9}500',
//                          style: GoogleFonts.robotoSlab(
//                     textStyle: const TextStyle(
//                         color: Color.fromARGB(255, 24, 115, 190),
//                         fontSize: 15,
                        
//                         fontWeight: FontWeight.bold),
//                         ),
//                         ),

//                         TextFormField(
                          
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//           floatingActionButton: Padding(
//             padding: const EdgeInsets.only(top: 76.0),
//             child: FloatingActionButton(
//               splashColor: Colors.lightBlueAccent,
//               elevation: 20,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Home_Page(),
//                   ),
//                 );
//               },
//               //HOME ICON

//               child: Icon(Octicons.home),

//               backgroundColor: Color.fromARGB(255, 21, 127, 213),
//             ),
//           ),
//           bottomNavigationBar: Padding(
//             padding: const EdgeInsets.only(right: 85.0, bottom: 4.0),
//             child: ClipPath(
//               clipper: ShapeBorderClipper(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               child: BottomAppBar(
//                 shadowColor: Colors.transparent,
//                 shape: const CircularNotchedRectangle(),
//                 notchMargin: 10.0,
//                 color: Color.fromARGB(255, 21, 127, 213),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     IconButton(
//                       tooltip: 'profile',
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Profile_Page(),
//                           ),
//                         );
//                       },
//                       icon: Icon(
//                         Typicons.user_outline,
//                         size: 32, // Reduced size
//                       ),
//                       color: Colors.white,
//                     ),
//                     IconButton(
//                       tooltip: 'stock',
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Stock_Page()));
//                       },
//                       icon: Icon(
//                         FontAwesome5.boxes,
//                         size: 30,
//                       ),
//                       color: Colors.white,
//                     ),
//                     IconButton(
//                       tooltip: 'product',
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Product_Page()));
//                       },
//                       icon: Icon(
//                         Zocial.paypal,
//                         size: 30, // Reduced size
//                       ),
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
