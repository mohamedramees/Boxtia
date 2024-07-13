// import 'package:boxtia_inventory/Screens/NewPassword.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';

// class OtpPage extends StatefulWidget {
//   const OtpPage({super.key});

//   @override
//   _OtpPageState createState() => _OtpPageState();
// }

// class _OtpPageState extends State<OtpPage> {
//   final List<TextEditingController> _otpControllers =
//       List.generate(6, (index) => TextEditingController());

//   // ignore: unused_element
//   void _clear() {
//     for (var controller in _otpControllers) {
//       controller.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var _time = '0:24';
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
//             //WELCOME
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 450.0),
//               child: Text(
//                 'OTP',
//                 style: GoogleFonts.mochiyPopOne(
//                   textStyle: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 33,
//                       letterSpacing: .8,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 70,
//             left: 0,
//             right: 0,
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Enter Verification Code',
//                     style: GoogleFonts.mochiyPopOne(
//                       textStyle: const TextStyle(
//                           color: Colors.blue,
//                           fontSize: 13,
//                           letterSpacing: .8,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   // Row of TextFormFields for OTP
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: List.generate(4, (index) {
//                       return SizedBox(
//                         width: 70,
//                         height: 60,
//                         child: TextField(
//                           controller: _otpControllers[index],
//                           keyboardType: TextInputType.number,
//                           textAlign: TextAlign.center,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1)
//                           ],
//                           style: TextStyle(fontSize: 24),
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                 color: Colors.blue, // border color
//                                 width: 3.0, // border width
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                 color: Colors.blue, // border color
//                                 width: 3.0, // border width
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                 color: Colors.blue, // border color when focused
//                                 width: 3.0, // border width when focused
//                               ),
//                             ),
//                           ),
//                           onChanged: (value) {
//                             if (value.length == 1) {
//                               if (index < _otpControllers.length - 1) {
//                                 FocusScope.of(context).nextFocus();
//                               } else {
//                                 FocusScope.of(context).unfocus();
//                               }
//                             }
//                           },
//                         ),
//                       );
//                     }),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 200.0),
//                     child: Text(
//                       'Resend in $_time',
//                       style: GoogleFonts.mochiyPopOne(
//                         textStyle: const TextStyle(
//                           color: Colors.blue,
//                           fontSize: 11,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 85,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (Context) => NewPassPage()));
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
//                       'VERIFY',
//                       style: GoogleFonts.museoModerno(
//                         textStyle: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 21,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 50.0,
//             right: 10.0,
//             child: Text(
//               'BOXTIA',
//               style: GoogleFonts.mogra(
//                 textStyle: const TextStyle(
//                     color: Color.fromARGB(255, 2, 242, 255),
//                     fontSize: 15,
//                     letterSpacing: 1,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
