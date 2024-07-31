import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                backgroundColor: WidgetStatePropertyAll(
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