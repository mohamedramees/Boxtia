// import 'package:boxtia_inventory/Screens/OTP.dart';
// import 'package:boxtia_inventory/services/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ForgotPage extends StatefulWidget {
//   const ForgotPage({super.key});

//   @override
//   _ForgotPageState createState() => _ForgotPageState();
// }

// class _ForgotPageState extends State<ForgotPage> {

//   final AuthService _authService = AuthService();

//   @override
//   void initState() {
//     super.initState();
//     _checkAuth();
//   }

//   Future<void> _checkAuth() async {
//     bool authenticated = await _authService.authenticate();
//     if (!authenticated) {

//       _showAuthFailedDialog();
//     }
//   }

//   void _showAuthFailedDialog() {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text('Authentication Failed'),
//         content: Text('Unable to authenticate. The app will close now.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(ctx).pop();
//               // Close the app
//               SystemNavigator.pop();
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   final TextEditingController _phoneController = TextEditingController();

//   void _clear() {
//     _phoneController.clear();
//   }

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
//             //WELCOME
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 450.0),
//               child: Text(
//                 '    Forgot\nPassword',
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
//                   //MOBILE NUMBER
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       controller: _phoneController,
//                       keyboardType: TextInputType.phone,
//                       inputFormatters: [LengthLimitingTextInputFormatter(10)],
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                         prefixIcon: Icon(
//                           Icons.phone,
//                           color: Colors.grey,
//                         ),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             Icons.clear,
//                             color: Colors.grey,
//                           ),
//                           onPressed: _clear,
//                         ),
//                         hintText: 'Mobile Number',
//                         hintStyle: TextStyle(
//                           color: Colors.grey,
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Value is empty';
//                         } else {
//                           return null;
//                         }
//                       },
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 85,
//                   ),

//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (Context) => OtpPage()));
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
//                       'CONFIRM',
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
