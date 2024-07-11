import 'dart:io';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Add_Item.dart';
import 'package:boxtia_inventory/Screens/Card_Product.dart';
import 'package:boxtia_inventory/Screens/Edit_Page.dart';
import 'package:boxtia_inventory/Screens/Profile_Page.dart';
import 'package:boxtia_inventory/Screens/Stock_Page.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:popup_menu/popup_menu.dart';

class Product_Page extends StatefulWidget {
  Product_Page({super.key});

  @override
  _Product_PageState createState() => _Product_PageState();
}

class _Product_PageState extends State<Product_Page> {
  String _businessName = '';
  List<itemModel> _items = [];

  TextEditingController textController = TextEditingController();

  final GlobalKey _menuKey = GlobalKey();

  late PopupMenu menu;

  @override
  void initState() {
    _fetchBusinessName();
    _fetchItems();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      menu = PopupMenu(
        context: context,
        config: MenuConfig(maxColumn: 3),
        items: [
          MenuItem(
            title: 'Category',
            image: Icon(FontAwesome.tags, color: Colors.white),
          ),
          MenuItem(
            title: 'Color',
            image: Icon(Icons.color_lens_outlined, color: Colors.white),
          ),
          MenuItem(
            title: 'Brand',
            image: Icon(LineariconsFree.smartphone, color: Colors.white),
          ),
          MenuItem(
            title: 'Price',
            image: Icon(FontAwesome.rupee, color: Colors.white),
          ),
        ],
        onClickMenu: onClickMenu,
        onDismiss: onDismiss,
      );
    });
  }

  void onClickMenu(MenuItemProvider item) {
    print('Clicked menu item: ${item.menuTitle}');
  }

  void onDismiss() {
    print('Menu is dismissed');
  }

  void _fetchBusinessName() async {
    final box = await Hive.openBox<userModel>('boxtiadb');
    List<userModel> users = box.values.toList();
    if (users.isNotEmpty) {
      setState(() {
        _businessName = users[0].bussinessName;
      });
    }
  }

  void _fetchItems() async {
    final Box = await Hive.openBox<itemModel>('boxtiaitemdb');
    List<itemModel> items = Box.values.toList();
    setState(() {
      _items = items;
    });
  }

  Future<void> deleteItem(int index) async {
    final box = await Hive.openBox<itemModel>('boxtiaitemdb');
    await box.deleteAt(index);
    setState(() {
      _items.removeAt(index);
    });
  }

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
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                _businessName.isNotEmpty ? _businessName : "BOXTIA",
                style: GoogleFonts.mogra(
                  textStyle: const TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 30,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
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
                    child: Row(
                      children: [
                        Text(
                          "PRODUCT",
                          style: GoogleFonts.mogra(
                            textStyle: const TextStyle(
                              decorationColor: Colors.tealAccent,
                              color: Colors.tealAccent,
                              fontSize: 20,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            toolbarHeight: 85,
          ),
          body: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            floatingActionButton: Column(
              children: [
                AnimSearchBar(
                  animationDurationInMilli: 300,
                  autoFocus: true,
                  style: TextStyle(color: Colors.white),
                  textFieldIconColor: Colors.white,
                  textFieldColor: Colors.blue,
                  suffixIcon: Icon(
                    RpgAwesome.x_mark,
                    color: Colors.white,
                  ),
                  rtl: true,
                  width: 400,
                  color: Color.fromARGB(255, 21, 127, 213),
                  searchIconColor: Colors.white,
                  textController: textController,
                  onSuffixTap: () {
                    textController.clear();
                  },
                  onSubmitted: (String) {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 360.0, top: 10),
                  child: FloatingActionButton(
                    key: _menuKey,
                    heroTag: "filterButton", // Unique hero tag
                    backgroundColor: Color.fromARGB(255, 21, 127, 213),
                    onPressed: () {
                      menu.show(widgetKey: _menuKey);
                    },
                    child: Icon(
                      Elusive.filter,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Card(
                    shadowColor: Colors.lightBlueAccent,
                    surfaceTintColor: Colors.lightBlueAccent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewUser()));
                        },
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          // ignore: unnecessary_null_comparison
                          child: item.ItemPicM == null
                              ? Image.asset(
                                  'lib/asset/no-image.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  alignment: Alignment.center,
                                  File(item.ItemPicM),
                                  width: 90,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.ItemNameM,
                              style: GoogleFonts.josefinSans(
                                textStyle: const TextStyle(
                                    decorationColor: Colors.tealAccent,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -2,
                                    fontSize: 19),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),

                        // trailing: Padding(
                        //   padding: const EdgeInsets.only(top: 40.0),
                        //   child: Text(
                        //       // 'Color: ${item.ColorM},
                        //       '\u{20B9}${item.PriceM}'),
                        // ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //  EDIT BUTTON
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Edit_Item(item: _items[index])),
                                ).then((_) {
                                  // Refresh data after editing
                                  _fetchItems();
                                });
                              },
                              icon: const Icon(
                                size: 20,
                                FontAwesome.pencil,
                                color: Colors.cyan,
                              ),
                            ),

                            //  DELETE BUTTON

                            IconButton(
                              onPressed: () {
                                deleteItem(index);
                              },
                              icon: const Icon(
                                size: 18,
                                Entypo.trash,
                                color: Colors.redAccent,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              // 'Color: ${item.ColorM},
                              '\u{20B9}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${item.PriceM}',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 76.0),
            child: FloatingActionButton(
              tooltip: 'add item',
              heroTag: "addItemButton",
              splashColor: Colors.lightBlueAccent,
              elevation: 20,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Add_Item()),
                ).then((_) {
                  _fetchItems();
                });
              },
              child: Icon(
                MfgLabs.plus,
                size: 25,
              ),
              backgroundColor: Color.fromARGB(255, 21, 127, 213),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(right: 85.0, bottom: 4.0),
            child: ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: BottomAppBar(
                shadowColor: Colors.transparent,
                shape: const CircularNotchedRectangle(),
                notchMargin: 10.0,
                color: Color.fromARGB(255, 21, 127, 213),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      tooltip: 'profile',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile_Page(),
                          ),
                        );
                      },
                      icon: Icon(
                        Typicons.user_outline,
                        size: 32, // Reduced size
                      ),
                      color: Colors.white,
                    ),
                    IconButton(
                      tooltip: 'stock',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Stock_Page()));
                      },
                      icon: Icon(
                        FontAwesome5.boxes,
                        size: 30,
                      ),
                      color: Colors.white,
                    ),
                    IconButton(
                      tooltip: 'product',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Product_Page()));
                      },
                      icon: Icon(
                        Zocial.paypal,
                        size: 30,
                      ),
                      color: Colors.lightGreenAccent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
