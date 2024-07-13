// import 'package:boxtia_inventory/Screens/login.dart';
// import 'package:boxtia_inventory/Screens/signup.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class welcomePage extends StatelessWidget {
//   const welcomePage({super.key});

//   BuildContext? get ctx1 => null;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.asset(
//             'lib/asset/dummy_page-0001.jpg',
//             width: double.infinity,
//             height: double.infinity,
//             fit: BoxFit.cover,
//           ),
//           Center(
//               child: Padding(
//             padding: const EdgeInsets.only(bottom: 450.0),
//             child: Text(
//               'WELCOME',
//               style: GoogleFonts.mochiyPopOne(
//                 textStyle: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 33,
//                     letterSpacing: .8,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           )),
//           Padding(
//             padding: const EdgeInsets.only(top: 600),
//             child: Column(
//               children: [
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                      Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPage()),
//                 );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 120, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     child: Text(
//                       'LOGIN',
//                       style: GoogleFonts.museoModerno(
//                         textStyle: const TextStyle(
//                             color: Colors.blue,
//                             fontSize: 21,
//                             letterSpacing: .8,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                          Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => signUpPage()),
//                 );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromARGB(255, 22, 132, 223),
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 105, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     child: Text(
//                       'SIGN UP',
//                       style: GoogleFonts.museoModerno(
//                         textStyle: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 21,
//                             letterSpacing: .8,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 50.0, right: 10),
//                 child: Text(
//                   'BOXTIA',
//                   style: GoogleFonts.mogra(
//                     textStyle: const TextStyle(
//                         color: Color.fromARGB(255, 2, 242, 255),
//                         fontSize: 15,
//                         letterSpacing: 1,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
// AnimSearchBar(
//                   animationDurationInMilli: 375,
//                   autoFocus: true,
//                   style: TextStyle(color: Colors.white),
//                   textFieldIconColor: Colors.white,
//                   textFieldColor: Colors.blue,
//                   suffixIcon: Icon(
//                     RpgAwesome.x_mark,
//                     color: Colors.white,
//                   ),
//                   rtl: true,
//                   width: 400,
//                   color: Color.fromARGB(255, 21, 127, 213),
//                   searchIconColor: Colors.white,
//                   textController: textController,
//                   onSuffixTap: () {
//                     textController.clear();
//                   },
//                   onSubmitted: (String) {},
//                 ),