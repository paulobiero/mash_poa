import 'dart:convert';

import 'package:mash/Models/userInfo.dart';
import 'package:mash/Services/AuthenticationServices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:progress_dialog/progress_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
              const Padding(
                child: Text(
                  "Welcome to Mash EA",
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
                    "Among the latest developments that have seen Mash having a niche over its competitors is in the incorporation, that saw the name and directors change from the previous Mash bus services Limited to Mash East Africa a broader aspect that has seen the company expanding its wings to all corners of the republic of Kenya and Kampala in Uganda.Plans are at an advanced stage to spread our services to all major cities in East Africa and its environs.Unlike other passenger transport companies Mash East Africa is a well-structured bus company run by a group of professional with international recognition. The management is comprised of a team of unquestionable integrity personnel having worked for home based passenger transport companies and also international companies such us the Stage Coach International PLC with its head quarters in the UK.The management is full of professionals with specialized training in passenger transport matters, having some affiliates, fellows and associated members of the Chartered institute of logistics and transport in the UK. This is professional body, which trains and produces the best and the highest qualified personnel in transport and logistics in the whole world.At Mash East Africa we ensure all our buses have proper fitted and serviced speed governors.Our drivers are well trained and molded to avoid any competitive driving on the road by being monitored by our track system.At Mash East Africa drivers work on a planned bus time schedule and on shift basis to avoid any fatigue on the road, making traveling with us the most safety way.We ensure our drivers go for an eye test after every 12 months especially those above 40 years to avoid poor vision on the road.At Mash East Africa all our driver are subject to pass the alcohol blow test before authorized to sign for their shift or allowed to drive drive.",
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
