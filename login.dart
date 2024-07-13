// import 'package:boxtia_inventory/Functions/DB_Functions.dart';
// import 'package:boxtia_inventory/Model/DB_Model.dart';
// import 'package:boxtia_inventory/Screens/NewPassword.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:boxtia_inventory/Screens/signup.dart';
// import 'package:boxtia_inventory/Screens/Home.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool _obscureText = true;
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   void _togglePasswordVisibility() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   void _clear() {
//     _phoneController.clear();
//   }

//   void _clearPassword() {
//     _passwordController.clear();
//   }

//   Future<void> _validate() async {
//   String mobNumber = _phoneController.text;
//   String password = _passwordController.text;

//   List<userModel> users = await getAllUsers();

//   userModel? matchedUser = users.firstWhere(
//     (user) => user.mobNumber == mobNumber && user.password == password,

//   );

//   if (matchedUser != null) {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => HomePage()),
//     );
//   } else {

//     Builder(builder: (BuildContext scaffoldContext) {
//       ScaffoldMessenger.of(scaffoldContext).showSnackBar(
//         SnackBar(
//           content: Text('Invalid mobile number or password.'),
//           duration: Duration(seconds: 5),
//         ),
//       );
//       return SizedBox.shrink(); // Return a placeholder widget if necessary
//     });
//   }
// }

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
//                 'Welcome\n     back',
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
//                   TextFormField(
//                     controller: _phoneController,
//                     keyboardType: TextInputType.phone,
//                     inputFormatters: [LengthLimitingTextInputFormatter(10)],
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
//                         onPressed: _clear,
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
//                     height: 15,
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
//                   Padding(
//                     padding: const EdgeInsets.only(left: 170.0),
//                     child: TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pushReplacement(
//                             MaterialPageRoute(
//                                 builder: (context) => NewPassPage()),
//                           );
//                         },
//                         child: Text(
//                           'Forgot Password?',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         )),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                     onPressed: _validate,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromARGB(255, 22, 132, 223),
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 105, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     child: Text(
//                       'LOGIN',
//                       style: GoogleFonts.museoModerno(
//                         textStyle: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 21,
//                             letterSpacing: .8,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),

//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 81.0,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           "Don't Have An Account?",
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
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => signUpPage()),
//                             );
//                           },
//                           child: Text(
//                             "Sign Up",
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
