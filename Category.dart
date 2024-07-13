// import 'package:boxtia_inventory/Screens/Home_Page.dart';
// import 'package:boxtia_inventory/Screens/Product_Page.dart';
// import 'package:boxtia_inventory/Screens/Profile_Page.dart';
// import 'package:boxtia_inventory/Screens/Stock_Page.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';
// import 'package:fluttericon/typicons_icons.dart';
// import 'package:fluttericon/zocial_icons.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Category_Page extends StatelessWidget {
//  Category_Page({super.key});

//  final _CatList = ['Mobile', 'Tablet', 'Watch', 'Accessories'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         shadowColor: Colors.transparent,
//         elevation: 10,
//         backgroundColor: Color.fromARGB(255, 21, 127, 213),
//         automaticallyImplyLeading: false,
//         title: Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: Text(
//             "BOXTIA",
//             style: GoogleFonts.mogra(
//               textStyle: const TextStyle(
//                   color: Colors.cyanAccent,
//                   fontSize: 30,
//                   letterSpacing: 1,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         actions: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 10.0),
//                 child: Text(
//                   "CATEGORY",
//                   style: GoogleFonts.mogra(
//                     textStyle: const TextStyle(
//                         decorationColor: Colors.tealAccent,
//                         color: Colors.tealAccent,
//                         fontSize: 20,
//                         letterSpacing: 1,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//         toolbarHeight: 85,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50),
//         child: ListView.builder(
//           itemCount: 4,
//           itemBuilder: (context, index) {
//             return Card(
//               color: Colors.blue,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ListTile(
//                   splashColor: Colors.tealAccent,
//                   title: Center(
//                     child: Text(
//                       _CatList[index],
//                       style: GoogleFonts.josefinSans(
//                                 textStyle: const TextStyle(
//                                     color: Colors.tealAccent,
//                                     fontWeight: FontWeight.bold,
//                                     letterSpacing: -2,
//                                     fontSize: 19),
//                               ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(top: 76.0),
//         child: FloatingActionButton(
//           tooltip: 'add item',
//           heroTag: "addItemButton",
//           splashColor: Colors.lightBlueAccent,
//           elevation: 20,
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Home_Page()),
//             );
//           },
//           child: Icon(
//             Icons.home,
//             size: 25,
//           ),
//           backgroundColor: Color.fromARGB(255, 21, 127, 213),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(right: 85.0, bottom: 4.0),
//         child: ClipPath(
//           clipper: ShapeBorderClipper(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//           ),
//           child: BottomAppBar(
//             shadowColor: Colors.transparent,
//             shape: const CircularNotchedRectangle(),
//             notchMargin: 10.0,
//             color: Color.fromARGB(255, 21, 127, 213),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 IconButton(
//                   tooltip: 'profile',
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Profile_Page(),
//                       ),
//                     );
//                   },
//                   icon: Icon(
//                     Typicons.user_outline,
//                     size: 32, // Reduced size
//                   ),
//                   color: Colors.white,
//                 ),
//                 IconButton(
//                   tooltip: 'stock',
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => Stock_Page()));
//                   },
//                   icon: Icon(
//                     FontAwesome5.boxes,
//                     size: 30,
//                   ),
//                   color: Colors.white,
//                 ),
//                 IconButton(
//                   tooltip: 'product',
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => Product_Page()));
//                   },
//                   icon: Icon(
//                     Zocial.paypal,
//                     size: 30,
//                   ),
//                   color: Colors.white,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
