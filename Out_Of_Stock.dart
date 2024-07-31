import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Featurs/FloatingButton.dart';
import 'package:boxtia_inventory/lib/services/AppColors.dart';
import 'package:flutter/material.dart';

class OutOfStock extends StatelessWidget {
  const OutOfStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
//^ BACKGROUND IMAGE

        Positioned.fill(
            child: Image.asset(
              'lib/asset/ScaffoldImage9.jpg',
              fit: BoxFit.cover,
            ),
          ),
        SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.scaffold,

//^ APP BAR

          appBar: appBars("OUT OF STOCK"),

//^ FLOATING ACTION BUTTON

            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 76.0),
              child: floatingToHome(context),
            ),

//^ BOTTOM APP BAR

        bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(right: 85.0, bottom: 4.0),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child:  bottomNavBar(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}