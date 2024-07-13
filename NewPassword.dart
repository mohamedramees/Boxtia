// import 'package:boxtia_inventory/Functions/DB_Functions.dart';
// import 'package:boxtia_inventory/Model/DB_Model.dart';
// import 'package:boxtia_inventory/Screens/login.dart';
// import 'package:boxtia_inventory/services/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';
// import 'package:google_fonts/google_fonts.dart';

// class NewPassPage extends StatefulWidget {
//   const NewPassPage({super.key});

//   @override
//   _NewPassPageState createState() => _NewPassPageState();
// }

// class _NewPassPageState extends State<NewPassPage> {
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

//               SystemNavigator.pop();
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   bool _obscureText = true;
//   bool _CobscureText = true;

//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _CpasswordController = TextEditingController();
//   // final TextEditingController _companyController = TextEditingController();

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

//   void _clearCPassword() {
//     _CpasswordController.clear();
//   }

//   void _clearPassword() {
//     _passwordController.clear();
//   }
// String? compName;

//   void _registerUser() async {

//     String password = _passwordController.text;
//     String cpassword = _CpasswordController.text;
//     // String compName = _companyController.text;

//     if (password.isNotEmpty && cpassword.isNotEmpty && password == cpassword) {

//       userModel newUser = userModel(
//         mobNumber:'',
//         compName:'',
//         password: password,
//         Cpassword: cpassword,
//       );

//       await addUser(newUser);

//        await updateUserPassword(newUser.key, password);

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Registration successful'),
//       ));

//       Navigator.pushReplacement(
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
//             //WELCOME
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 450.0),
//               child: Text(
//                 'Create New \n   Password',
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
//                   //PASSWORD
//                   TextFormField(
//                     keyboardType: TextInputType.number,
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
//                     height: 35,
//                   ),
//                   //CONFIRM PASSWORD
//                   TextFormField(
//                     keyboardType: TextInputType.number,
//                     inputFormatters: [LengthLimitingTextInputFormatter(12)],
//                     controller: _CpasswordController,
//                     obscureText: _CobscureText,
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(
//                         Icons.lock_outlined,
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
//                   SizedBox(
//                     height: 35,
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
//                       'CONTINUE',
//                       style: GoogleFonts.museoModerno(
//                         textStyle: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             letterSpacing: 0.2,
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
