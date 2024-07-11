import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewUser extends StatefulWidget {
  const ViewUser({
    Key? key,
  }) : super(key: key);

  get user => null;

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "BOXTIA",
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
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      "EDIT ITEM",
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
          body: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('lib/asset/no-image.png'),

                ListView.builder(
                    // itemCount:
                    itemBuilder: (context, index) {
                  return Card(
                    
                  );
                }),
                // Column(
                //   children: [
                //     SizedBox(
                //       height: 30,
                //     ),
                //     Row(
                //       children: [
                //         const Expanded(
                //           child: Padding(
                //             padding: EdgeInsets.only(left: 010),
                //             child: Text(
                //               'Item Name',
                //               style: TextStyle(
                //                 fontSize: 23,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.blue,
                //               ),
                //             ),
                //           ),
                //         ),
                //         Expanded(
                //           child: Padding(
                //             padding: const EdgeInsets.only(left: 0),
                //             child: Text('55'
                //                 // // widget.user.name ?? '',
                //                 // style: const TextStyle(
                //                 //   fontSize: 20,
                //                 //   fontWeight: FontWeight.bold,
                //                 //   color: Color.fromARGB(255, 6, 235, 251),
                //                 // ),
                //                 ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         const Expanded(
                //           child: Padding(
                //             padding: EdgeInsets.only(left: 10),
                //             child: Text(
                //               'Category',
                //               style: TextStyle(
                //                 fontSize: 23,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.blue,
                //               ),
                //             ),
                //           ),
                //         ),
                //         Expanded(
                //           child: Padding(
                //             padding: const EdgeInsets.only(),
                //             child: Text('Brand'),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         const Expanded(
                //           child: Padding(
                //             padding: EdgeInsets.only(left: 10),
                //             child: Text(
                //               'Brand',
                //               style: TextStyle(
                //                 fontSize: 23,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.blue,
                //               ),
                //             ),
                //           ),
                //         ),
                //         Expanded(
                //           child: Padding(
                //             padding: const EdgeInsets.only(),
                //             child: Text('Color'),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         const Expanded(
                //           child: Padding(
                //             padding: EdgeInsets.only(left: 10),
                //             child: Text(
                //               'Color',
                //               style: TextStyle(
                //                 fontSize: 23,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.blue,
                //               ),
                //             ),
                //           ),
                //         ),
                //         Expanded(
                //           child: Padding(
                //             padding: const EdgeInsets.only(),
                //             child: Text('b'),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         const Expanded(
                //           child: Padding(
                //             padding: EdgeInsets.only(left: 10),
                //             child: Text(
                //               'Price',
                //               style: TextStyle(
                //                 fontSize: 23,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.blue,
                //               ),
                //             ),
                //           ),
                //         ),
                //         Expanded(
                //           child: Padding(
                //             padding: const EdgeInsets.only(),
                //             child: Text('b'),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
