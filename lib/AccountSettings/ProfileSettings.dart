import 'dart:convert';
import 'dart:io';

import 'package:mash/AccountSettings/ProfileScreen.dart';
import 'package:mash/AccountSettings/ResetPasswordPage.dart';
import 'package:mash/Models/userInfo.dart';
import 'package:mash/Services/AuthenticationServices.dart';
import 'package:mash/Services/Theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_text_drawable/flutter_text_drawable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileSettings extends StatefulWidget {
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  bool isLoading = true;

  String password = "";
  UserInfo userInfo = UserInfo();

  @override
  void initState() {
    super.initState();
    // futureAlbum=fetchAlbum();
    AuthenticationServices().getUser().then((value) => {
          setState(() {
            userInfo = value;

            isLoading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600);

    return Scaffold(
        appBar: AppBar(
            title: Text(
              "My Profile",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black)),
        body: isLoading
            ? const LinearProgressIndicator()
            : SingleChildScrollView(
                physics: ScrollPhysics(),
                child: SafeArea(
                  top: true,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Padding(
                          padding:
                              const EdgeInsets.only(left: 20, right: 20, top: 30),
                          child: Text(
                            "Manage your personal info and control what is seen when you use your main Transline customer account and other services in the Transline booking application",
                            style: GoogleFonts.rubik(),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    userInfo.name,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,

                                      color: Colors.black,
                                    )),
                                  ),
                                  Text(
                                    userInfo.phone,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,

                                      color: Colors.black,
                                    )),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: TextDrawable(
                                      text: userInfo.name,
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      isTappable: false,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 1,
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.edit, color: Colors.black),
                                  Text(
                                    "Edit profile",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black,
                                    )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Edit and update your profile details ie.First name,Middle name,last name and the profile image",
                                style: TextStyle(fontFamily: 'Montserrat'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color:  Colors.green.shade700,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text('Edit profile',
                                          style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    )),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => ProfileScreen(),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "Change Password",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black,
                                    )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Change your password to one you can easily remember",
                                style: TextStyle(fontFamily: 'Montserrat'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color:  Colors.green.shade700,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text('Change password',
                                          style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    )),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => ResetPasswordPage(title: 'title'),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
