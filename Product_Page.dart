import 'dart:io';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:boxtia_inventory/Featurs/App_Bar.dart';
import 'package:boxtia_inventory/Featurs/Bottom_AppBar.dart';
import 'package:boxtia_inventory/Featurs/FloatingButton.dart';
import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:boxtia_inventory/Screens/Edit_Page.dart';
import 'package:boxtia_inventory/Screens/Home_Page.dart';
import 'package:boxtia_inventory/Screens/Item_Page.dart';
import 'package:boxtia_inventory/services/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:popup_menu/popup_menu.dart';

class Product_Page extends StatefulWidget {
  Product_Page({super.key});

  @override
  _Product_PageState createState() => _Product_PageState();
}

class _Product_PageState extends State<Product_Page> {

  List<itemModel> _items = [];

  ValueNotifier<String> _selectedCategory = ValueNotifier<String>('All');
  ValueNotifier<String> _searchKeyword = ValueNotifier<String>('');

  TextEditingController textController = TextEditingController();

  final GlobalKey _menuKey = GlobalKey();

//  ignore: unused_field
  bool _popupMenuEnabled = true;
  late PopupMenu menu;

  @override
  void initState() {

    _fetchItems();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    //^ FILTER MENU
      menu = PopupMenu(
        context: context,
        config: MenuConfig(maxColumn: 3),
        items: [
          MenuItem(
            title: 'Mobiles',
            image: Icon(Linecons.mobile, color: Colors.white),
          ),
          MenuItem(
            title: 'Tablet',
            image: Icon(Icons.tablet_android_outlined, color: Colors.white),
          ),
          MenuItem(
            title: 'Watch',
            image: Icon(Typicons.wristwatch, color: Colors.white),
          ),
          MenuItem(
            title: 'Accessories',
            image: Icon(FontAwesome5.headset, color: Colors.white),
          ),
        ],
        onClickMenu: onClickMenu,
        onDismiss: onDismiss,
      );
    });
    textController.addListener(() {
      _searchKeyword.value = textController.text;
    });
  }

  void onClickMenu(MenuItemProvider item) {
    print('Selected Category: ${item.menuTitle}');
    setState(() {
      _selectedCategory.value = item.menuTitle;
    });
    menu.dismiss();
  }

  void onDismiss() {
    print('Menu is dismissed');
  }

//^  FETCH ITEMS

  void _fetchItems() async {
    final Box = await Hive.openBox<itemModel>('boxtiaitemdb');
    List<itemModel> items = Box.values.toList();
    setState(() {
      _items = items;
    });
  }

//^ DELETE ITEMS

  Future<void> deleteItem(int index) async {
    final box = await Hive.openBox<itemModel>('boxtiaitemdb');
    await box.deleteAt(index);
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home_Page()),
        );
        return false;
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/asset/ScaffoldImage9.jpg',
              fit: BoxFit.cover,
            ),
          ),
         SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,

//^ APPBAR

            appBar:appBars("PRODUCTS"),

//^ BODY BUTTON

            body: Scaffold(backgroundColor: Colors.transparent,
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
              floatingActionButton: Column(
                children: [
//^ SEARCH BAR
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
                    color: AppColor.floating,
                    searchIconColor: Colors.white,
                    textController: textController,
                    onSuffixTap: () {
                      textController.clear();
                      _searchKeyword.value = '';
                    },
                    onSubmitted: (String value) {
                      _searchKeyword.value = value;
                    },
                  ),
//^ FILTER BUTTON

                  Padding(
                    padding: const EdgeInsets.only(left: 360.0, top: 10),
                    child: FloatingActionButton(
                      key: _menuKey,
                      heroTag: "filterButton",
                      backgroundColor: AppColor.floating,
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
//^ MAIN BODY
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ValueListenableBuilder<String>(
                  valueListenable: _selectedCategory,
                  builder: (context, selectedCategory, child) {
                    return ValueListenableBuilder<String>(
                      valueListenable: _searchKeyword,
                      builder: (context, searchKeyword, child) {
                        print('Current Selected Category: $selectedCategory');
                        print('Current Search Keyword: $searchKeyword');
                        final filteredItems = _items.where((item) {
                          final categoryMatch =
                              selectedCategory.toLowerCase() == 'all' ||
                                  item.CategoryM.toLowerCase() ==
                                      selectedCategory.toLowerCase();
                          final keywordMatch = item.ItemNameM.toLowerCase()
                              .contains(searchKeyword.toLowerCase());
                          return categoryMatch && keywordMatch;
                        }).toList();
                        print('Filtered Items Count: ${filteredItems.length}');

                        if (filteredItems.isEmpty) {
                          return Center(
                            child: Text('NO ITERMS !!!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.white
                            ),
                            ),
                          );
                        }
//^ LIST

                        return ListView.builder(
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];

                            return Card(
                              shadowColor: Colors.lightBlueAccent,
                              surfaceTintColor: AppColor.white,
                              color: AppColor.scaffold,
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
                                          builder: (context) => Item_Page(
                                                item: filteredItems[index],
                                              )),
                                    ).then((_) {
                                    //^  Refresh data after editing
                                      _fetchItems();
                                    });
                                  },
//^ IMAGE

                                  leading: SizedBox(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                    //  ignore: unnecessary_null_comparison
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
                                  ),
//^ TITLE NAME

                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.ItemNameM,
                                        style: GoogleFonts.josefinSans(
                                          textStyle: const TextStyle(
                                              color: AppColor.itemName,
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

                                  subtitle: Row(
                                    children: [
//^ RUPEE
                                      Text(
                                        '\u{20B9}',
                                        style: TextStyle(
                                            color: AppColor.white,
                                            fontWeight: FontWeight.bold),
                                      ),
//^ PRICE
                                      Text(
                                        '${item.PriceM}',
                                        style: TextStyle(
                                            color: AppColor.white,
                                            fontWeight: FontWeight.bold),
                                      ),
//^ POP UP MENU
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: PopupMenuButton<int>(
                                            onSelected: (value) {
//^  BUTTON USE
                                              if (value == 1) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Edit_Item(
                                                      item:
                                                          filteredItems[index],
                                                      index: index,
                                                    ),
                                                  ),
                                                );
                                              } else if (value == 2) {
                                                deleteItem(index);
                                              }
                                            },
                                            itemBuilder:
                                                (BuildContext context) => [
                                              PopupMenuItem<int>(
//^ EDIT BUTTON
                                                value: 1,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesome.pencil,
                                                      size: 20,
                                                      color: Colors.cyan,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text("Edit"),
                                                  ],
                                                ),
                                              ),
                                              PopupMenuItem<int>(
//^ DELETE BUTTON
                                                value: 2,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Entypo.trash,
                                                      size: 18,
                                                      color: Colors.redAccent,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text("Delete"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
//^ FLOATING ACTION BUTTON
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 76.0),
              child:floatingAddItemButton(context),

            ),

//^ BOTTOM BAR

            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(right: 85.0, bottom: 4.0),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: bottomNavBar(context),
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}
