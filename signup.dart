// import 'package:boxtia_inventory/Functions/DB_Functions.dart';
// import 'package:boxtia_inventory/Model/DB_Model.dart';
// import 'package:boxtia_inventory/Screens/login.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';
// import 'package:google_fonts/google_fonts.dart';

// class signUpPage extends StatefulWidget {
//   const signUpPage({super.key});

//   @override
//   _signUpPageState createState() => _signUpPageState();
// }

// class _signUpPageState extends State<signUpPage> {
//   bool _obscureText = true;
//   bool _CobscureText = true;
//   final TextEditingController _companyController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _CpasswordController = TextEditingController();

//   void _togglePasswordVisibility() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   void _toggleCPasswordVisibility() {
//     setState(() {
//       _CobscureText = !_CobscureText;
//     });
//   }

//   void _clear() {
//     _companyController.clear();
//   }

//   void _clearPassword() {
//     _passwordController.clear();
//   }

//   void _clearPhone() {
//     _phoneController.clear();
//   }

//   void _clearCPassword() {
//     _CpasswordController.clear();
//   }

//   void _registerUser() async {

//     String compName = _companyController.text;
//     String mobNumber = _phoneController.text;
//     String password = _passwordController.text;
//     String cpassword = _CpasswordController.text;

//     if (compName.isNotEmpty &&
//         mobNumber != 0 &&
//         password.isNotEmpty &&
//         cpassword.isNotEmpty &&
//         password == cpassword) {

//       userModel newUser = userModel(
//         compName: compName,
//         mobNumber: mobNumber,
//         password: password,
//         Cpassword: cpassword,
//       );

//       await addUser(newUser);

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Registration successful'),
//       ));

//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => LoginPage()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Please fill all fields'),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.asset(
//             'lib/asset/BordingBackground.jpg',
//             width: double.infinity,
//             height: double.infinity,
//             fit: BoxFit.cover,
//           ),
//           Center(
//             //CREATE ACCOUNT
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 450.0),
//               child: Text(
//                 'Create Your\n     Account',
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
//                   //COMPANY NAME
//                   TextFormField(
//                     controller: _companyController,
//                     keyboardType: TextInputType.name,
//                     inputFormatters: [LengthLimitingTextInputFormatter(15)],
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(
//                         FontAwesome5.building,
//                         color: Colors.grey,
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           Icons.clear,
//                           color: Colors.grey,
//                         ),
//                         onPressed: _clear,
//                       ),
//                       border: InputBorder.none,
//                       hintText: 'Company Name',
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Value is empty';
//                       } else {
//                         return null;
//                       }
//                     },
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),

//                   //MOBILE NUMBER

//                   TextFormField(
//                     controller: _phoneController,
//                     keyboardType: TextInputType.phone,
//                     inputFormatters: [
//                       LengthLimitingTextInputFormatter(10),
//                     ],
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(
//                         Icons.phone,
//                         color: Colors.grey,
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           Icons.clear,
//                           color: Colors.grey,
//                         ),
//                         onPressed: _clearPhone,
//                       ),
//                       border: InputBorder.none,
//                       hintText: 'Mobile Number',
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Value is empty';
//                       } else {
//                         return null;
//                       }
//                     },
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),

//                   //PASSWORD

//                   TextFormField(
//                     keyboardType: TextInputType.phone,
//                     inputFormatters: [LengthLimitingTextInputFormatter(12)],
//                     controller: _passwordController,
//                     obscureText: _obscureText,
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(
//                         Icons.lock_open_outlined,
//                         color: Colors.grey,
//                       ),
//                       suffixIcon: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               _obscureText
//                                   ? FontAwesome5.eye_slash
//                                   : FontAwesome5.eye,
//                               color: Colors.grey,
//                             ),
//                             onPressed: _togglePasswordVisibility,
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               Icons.clear,
//                               color: Colors.grey,
//                             ),
//                             onPressed: _clearPassword,
//                           ),
//                         ],
//                       ),
//                       border: InputBorder.none,
//                       hintText: 'Password',
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Value is empty';
//                       } else {
//                         return null;
//                       }
//                     },
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                   ),

//                   SizedBox(
//                     height: 10,
//                   ),

//                   //CONFIRM PASSWORD
//                   TextFormField(
//                     keyboardType: TextInputType.phone,
//                     inputFormatters: [LengthLimitingTextInputFormatter(12)],
//                     controller: _CpasswordController,
//                     obscureText: _CobscureText,
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(
//                         Icons.lock_open_outlined,
//                         color: Colors.grey,
//                       ),
//                       suffixIcon: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               _CobscureText
//                                   ? FontAwesome5.eye_slash
//                                   : FontAwesome5.eye,
//                               color: Colors.grey,
//                             ),
//                             onPressed: _toggleCPasswordVisibility,
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               Icons.clear,
//                               color: Colors.grey,
//                             ),
//                             onPressed: _clearCPassword,
//                           ),
//                         ],
//                       ),
//                       border: InputBorder.none,
//                       hintText: 'Confirm Password',
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Value is empty';
//                       } else {
//                         return null;
//                       }
//                     },
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                   ),

//                   ElevatedButton(
//                     onPressed: () {
//                       _registerUser();
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
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 81.0,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           "Do you Have An Account?",
//                           style: GoogleFonts.mochiyPopOne(
//                             textStyle: const TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 8,
//                                 letterSpacing: -.2,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => LoginPage()),
//       );
//                           },
//                           child: Text(
//                             "Sign In",
//                             style: GoogleFonts.mochiyPopOne(
//                               textStyle: const TextStyle(
//                                   color: Colors.blue,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
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
