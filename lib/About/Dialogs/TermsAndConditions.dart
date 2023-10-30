import 'dart:convert';

import 'package:mash/Models/userInfo.dart';
import 'package:mash/Services/AuthenticationServices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:progress_dialog/progress_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TermsAndConditions extends StatefulWidget {
  TermsAndConditions({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _TermsAndConditions createState() => _TermsAndConditions();
}

class _TermsAndConditions extends State<TermsAndConditions> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  String bullet = "\u2022 ";
  bool _isHidden = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Terms and Conditions",
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
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet This ticket is valid for the time and date of travel only",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text("$bullet The ticket cannot be altered, resold, transferred or refunded",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet If for any reason the holder fails to report before departure time, the company accepts no responsibility for such passenger",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet The ticket is treated as used if the holder fails to utilize it as indicated there on",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet The ticket holder must report at the booking office 30 minutes before the time specific on the ticket",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet Drinking any alcohol, chewing miraa or smoking in the coach is prohibited",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet Luggage carried at owner’s risk. The company cannot be held responsible for damage, losses or delay. Passengers are to take care of their own luggage",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet 20kgs of luggage is allowed free. Additional will be accepts on charge if space permits",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet The management reserves the right to change the coach without prior notice or refund.",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet If in case a passenger breaks his journey en-route no refund shall be made",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet A passenger is allowed free one baby only. Age limit 5 yrs.",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet Passengers are requested to ensure correctness of the booking office as mistakes cannot be rectified later",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet Strictly no luggage should be passed through the window",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet The passenger should ensure that the amount paid is clearly indicated on the ticket as per one’s destination",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet Time and date of booking should appear clearly on the ticket",
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
