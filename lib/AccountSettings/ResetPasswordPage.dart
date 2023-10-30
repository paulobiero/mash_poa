import 'dart:convert';

import 'package:mash/Models/userInfo.dart';
import 'package:mash/Services/AuthenticationServices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:progress_dialog/progress_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();

  final myController4 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AuthenticationServices().getUser().then((value) => {
          setState(() {
            userInfo = value;
          })
        });
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
            "Reset password",
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
                  "Tips for strong password",
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
                    "$bullet Use a unique password that is hard to guess",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text("$bullet Use a combination of numbers and symbols",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet Use a password that you'll be using only for your Mash poa booking app account",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "$bullet Keep your password secret. We'll never ask for your password by email, instant message or phone",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Form(
                  key: _formKey,
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 0.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          top: 2.0, bottom: 2, left: 20),
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white70),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: Colors.grey.shade300),
                                      child: TextFormField(
                                          autofocus: false,
                                          obscureText: _isHidden,
                                          validator: (value) => value!.isEmpty
                                              ? "Please enter Old password"
                                              : null,
                                          controller: myController1,
                                          textInputAction: TextInputAction.done,

                                          decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _isHidden
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.black,
                                                ),
                                                onPressed: _togglePasswordView,
                                              ),
                                              border: InputBorder.none,
                                              icon: Icon(Icons.lock),
                                              hintText: "Enter Old Password",
                                              hintStyle: TextStyle(
                                                  color: Colors.black)))),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 0.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          top: 2.0, bottom: 2, left: 20),
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white70),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: Colors.grey.shade300),
                                      child: TextFormField(
                                          autofocus: false,
                                          obscureText: _isHidden,
                                          validator: (value) => value!.isEmpty
                                              ? "Please enter new password"
                                              : null,
                                          controller: myController2,
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _isHidden
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.black,
                                                ),
                                                onPressed: _togglePasswordView,
                                              ),
                                              border: InputBorder.none,
                                              icon: Icon(Icons.lock),
                                              hintText: "Enter new Password",
                                              hintStyle: TextStyle(
                                                  color: Colors.black)))),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 0.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          top: 2.0, bottom: 2, left: 20),
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white70),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: Colors.grey.shade300),
                                      child: TextFormField(
                                          autofocus: false,
                                          obscureText: _isHidden,
                                          controller: myController3,
                                          validator: (value) => value!.isEmpty
                                              ? "Please confirm new password"
                                              : null,
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _isHidden
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.black,
                                                ),
                                                onPressed: _togglePasswordView,
                                              ),
                                              border: InputBorder.none,
                                              icon: Icon(Icons.lock),
                                              hintText: "Confirm Password",
                                              hintStyle: TextStyle(
                                                  color: Colors.black)))),
                                ),
                              ],
                            )),
                        const SizedBox(height: 40.0),
                      ],
                    ),
                  )),
              Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                    height: 40.0,
                    child: GestureDetector(
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.orange.shade700,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text('Change password',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          )),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          String oldpassword = myController1.text;
                          String newPassword = myController2.text;
                          String newPassordConfirm = myController3.text;
                          if (newPassordConfirm != newPassword) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text("password do not match"),
                            ));
                            return;
                          }

                          AuthenticationServices()
                              .changePassword(
                                  newPassordConfirm, newPassword, oldpassword)
                              .then((value) => {
                                    if (value['isSuccess'])
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(value['msg']),
                                        )),
                                        Navigator.pop(context)
                                      }
                                    else
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(value['msg']),
                                        ))
                                      }
                                  });
                          FocusScope.of(context).unfocus();
                        }
                      },
                    )),
              ),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
