import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:boxtia_inventory/Functions/DB_Functions.dart';

class Profile_Page extends StatefulWidget {
  @override
  _Profile_PageState createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  final TextEditingController _BnameController = TextEditingController();
  final TextEditingController _BTypeController = TextEditingController();
  final TextEditingController _PlaceController = TextEditingController();
  final TextEditingController _MnumberController = TextEditingController();
  final TextEditingController _OnameController = TextEditingController();

  
  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeType = FocusNode();
  final FocusNode _focusNodeOwner = FocusNode();
  final FocusNode _focusNodePlace = FocusNode();
  final FocusNode _focusNodeMnumber = FocusNode();

  bool _isFocusedName = false;
  bool _isFocusedType = false;
  bool _isFocusedOwner = false;
  bool _isFocusedPlace = false;
  bool _isFocusedMnumber = false;

  String Bname = "Enter Business Name Here";
  String Btype = "Enter Business Type Here";
  String Country = "Enter Place Here";
  String Mnumber = "Enter Mobile Number Here";
  String Owner = "Enter Owner Name Here";

  @override
  void initState() {
    super.initState();
      _focusNodeName.addListener(() {
      setState(() {
        _isFocusedName = _focusNodeName.hasFocus;
      });
    });
      _focusNodeType.addListener(() {
      setState(() {
        _isFocusedType = _focusNodeType.hasFocus;
      });
    });
    _focusNodeOwner.addListener(() {
      setState(() {
        _isFocusedOwner = _focusNodeOwner.hasFocus;
      });
    });
    _focusNodePlace.addListener(() {
      setState(() {
        _isFocusedPlace = _focusNodePlace.hasFocus;
      });
    });
    _focusNodeMnumber.addListener(() {
      setState(() {
        _isFocusedMnumber = _focusNodeMnumber.hasFocus;
      });
    });
    fetchAndSetUserData();
  }

   @override
  void dispose() {
    _BnameController.dispose();
    _BTypeController.dispose();
    _PlaceController.dispose();
    _MnumberController.dispose();
    _OnameController.dispose();
    _focusNodeName.dispose();
    _focusNodeType.dispose();
    _focusNodeOwner.dispose();
    _focusNodePlace.dispose();
    _focusNodeMnumber.dispose();
    super.dispose();
  }


  void fetchAndSetUserData() async {
    List<userModel> users = await getAllUsers();
    if (users.isNotEmpty) {
      setState(() {
        _BnameController.text = users[0].bussinessName;
        _BTypeController.text = users[0].bussiType;
        _OnameController.text = users[0].oName;
        _PlaceController.text = users[0].place;
        _MnumberController.text = users[0].mobileNumber;
      });
    }
  }

  void _clearBname() {
    _BnameController.clear();
  }

  void _clearBtype() {
    _BTypeController.clear();
  }

  void _clearCountry() {
    _PlaceController.clear();
  }

  void _clearMnumber() {
    _MnumberController.clear();
  }

  void _clearOwner() {
    _OnameController.clear();
  }

  Future<void> _registerUser(BuildContext context) async {
    String _Bname = _BnameController.text;
    String _Btype = _BTypeController.text;
    String _Oname = _OnameController.text;
    String _Country = _PlaceController.text;
    String _Mnumber = _MnumberController.text;

    if (_Bname.isNotEmpty &&
        _Btype.isNotEmpty &&
        _Oname.isNotEmpty &&
        _Country.isNotEmpty &&
        _Mnumber.isNotEmpty) {
      userModel newUser = userModel(
        bussinessName: _Bname,
        bussiType: _Btype,
        oName: _Oname,
        place: _Country,
        mobileNumber: _Mnumber,
      );

      await addUser(newUser);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            duration: Duration(seconds: 1),
            content: Text('User data saved successfully!')),
      );

      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
    }
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
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _BnameController,
                builder: (context, value, child) {
                  return Text(
                    value.text.isEmpty ? "BOXTIA" : value.text,
                    style: GoogleFonts.mogra(
                      textStyle: const TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 30,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
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
                      "PROFILE",
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                // BUSSINESS NAME
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    focusNode: _focusNodeName,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    controller: _BnameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue)),
                      hintText: Bname,
                      hintStyle: TextStyle(color: Colors.blue),
                      suffixIcon: _isFocusedName
                          ? IconButton(
                              onPressed: _clearBname,
                              icon: Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                            )
                          : null,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
                // Business Type
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    focusNode: _focusNodeType,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    controller: _BTypeController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue)),
                      hintText: Btype,
                      hintStyle: TextStyle(color: Colors.blue),
                      suffixIcon: _isFocusedType
                          ? IconButton(
                              onPressed: _clearBtype,
                              icon: Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                            )
                          : null,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
                // Owner Name
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    focusNode: _focusNodeOwner,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    controller: _OnameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue)),
                      hintText: Owner,
                      hintStyle: TextStyle(color: Colors.blue),
                      suffixIcon: _isFocusedOwner
                          ? IconButton(
                              onPressed: _clearOwner,
                              icon: Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                            )
                          : null,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
                // Place
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    focusNode: _focusNodePlace,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    controller: _PlaceController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue)),
                      hintText: Country,
                      hintStyle: TextStyle(color: Colors.blue),
                      suffixIcon: _isFocusedPlace
                          ? IconButton(
                              onPressed: _clearCountry,
                              icon: Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                            )
                          : null,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
                // Mobile Number
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    focusNode: _focusNodeMnumber,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    controller: _MnumberController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue)),
                      hintText: Mnumber,
                      hintStyle: TextStyle(color: Colors.blue),
                      suffixIcon: _isFocusedMnumber
                          ? IconButton(
                              onPressed: _clearMnumber,
                              icon: Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                            )
                          : null,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Container(
            width: 70,
            height: 130,
            child: Padding(
              padding: const EdgeInsets.only(top: 72.0),
              child: FloatingActionButton(
                splashColor: Colors.lightBlueAccent,
                elevation: 20,
                onPressed: () {
                  _registerUser(context);
                },
                child: Text(
                  'SAVE',
                  style: GoogleFonts.odibeeSans(
                    textStyle: TextStyle(
                      color: Colors.cyanAccent[100],
                      fontSize: 15,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                backgroundColor: Color.fromARGB(255, 21, 127, 213),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(right: 170.0, bottom: 4.0),
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
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesome5.boxes,
                            size: 30,
                          ),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => Product_Page(),
                            //   ),
                            // );
                          },
                          icon: Icon(
                            Zocial.paypal,
                            size: 30,
                          ),
                          color: Colors.white,
                        ),
                      ],
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
