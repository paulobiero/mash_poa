import 'dart:convert';

import 'package:mash/Models/userInfo.dart';
import 'package:mash/Services/AuthenticationServices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:progress_dialog/progress_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Utils/Constants.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AboutUs createState() => _AboutUs();
}

class _AboutUs extends State<AboutUs> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  String bullet = "\u2022 ";
  bool _isHidden = true;

  void nextField({String? value, FocusNode? focus}) {
    if (value!.length == 1) {
      focus!.requestFocus();
    }
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
      print("test " + _isHidden.toString());
    });
  }

  late UserInfo userInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "About Us",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black)),
      body: SingleChildScrollView(
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               Padding(
                child: Text(
                  "Welcome to ${AppUrl.companyName}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.all(20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "${AppUrl.companyAbout}",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),



              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
