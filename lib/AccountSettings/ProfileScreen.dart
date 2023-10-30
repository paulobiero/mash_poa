import 'dart:convert';

import 'package:mash/Models/userInfo.dart';
import 'package:mash/Services/AuthenticationServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text_drawable/flutter_text_drawable.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Utils/UpperCaseTextFormatter.dart';

class ProfileScreen extends StatefulWidget {
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _status = true;
  late String first, last, phone, email, id;

  GlobalKey<FormState> _formKey1 = new GlobalKey<FormState>();
  GlobalKey<FormState> _formKey2 = new GlobalKey<FormState>();
  String version = "";
  String buildNumber = "";
  bool isResetPassword = false;

  bool _isUploading = false;

  bool _isProfileEdited = false;
  var kMarginPadding = 16.0;
  var kFontSize = 13.0;
  late final ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );
    pr.style(message: "Please wait");
    futureAlbum = AuthenticationServices().getUser();
    futureAlbum.then((value) => {
          setState(() {
            first = value.name.split(" ").first;
            last = value.name.split(" ").last;
            email = value.email;
            id = value.id_number;
            phone = value.phone;
          })
        });
  }

  late Future<UserInfo> futureAlbum;

  @override
  Widget build(BuildContext context) {
    globalContext=context;
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: FutureBuilder<UserInfo>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 250.0,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 20.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                      size: 22.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 25.0),
                                      child: Text('Edit profile',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              fontFamily: 'sans-serif-light',
                                              color: Colors.black)),
                                    )
                                  ],
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 40.0),
                            child:
                                Stack(fit: StackFit.loose, children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 140,
                                    width: 140,
                                    child: TextDrawable(
                                      text: snapshot.data!.name,
                                      textStyle: const TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold),
                                      isTappable: false,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xffFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: Form(
                          key: _formKey1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const <Widget>[
                                          Text(
                                            'Personal Information',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _status
                                              ? _getEditIcon()
                                              : new Container(),
                                        ],
                                      )
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: new Text(
                                            'First Name',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: new Text(
                                            'Second Name',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                hintText: "Enter First name"),
                                            enabled: !_status,
                                            initialValue: snapshot.data!.name
                                                .split(" ")[0],
                                            onSaved: (s) {
                                              first = s!;
                                            },
                                            inputFormatters: <TextInputFormatter>[
                                              UpperCaseTextFormatter()
                                            ],
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              hintText: "Enter second Name"),
                                          enabled: !_status,
                                          initialValue:
                                              snapshot.data!.name.split(" ")[1],
                                          onSaved: (s) {
                                            last = s!;
                                          },
                                          inputFormatters: <TextInputFormatter>[
                                            UpperCaseTextFormatter()
                                          ],
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Email address',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Phone number',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: TextFormField(
                                            onSaved: (s) {
                                              email = s!;
                                            },
                                            decoration: const InputDecoration(
                                                hintText:
                                                    "Enter email address"),
                                            enabled: !_status,
                                            initialValue: snapshot.data!.email,
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          onSaved: (s) {
                                            phone = s!;
                                          },
                                          decoration: const InputDecoration(
                                              hintText: "Enter phone number"),
                                          enabled: !_status,
                                          initialValue: snapshot.data!.phone,
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Id Number',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: TextFormField(
                                            onSaved: (s) {
                                              id = s!;
                                            },
                                            decoration: const InputDecoration(
                                                hintText: "Enter Id number"),
                                            enabled: !_status,
                                            initialValue:
                                                snapshot.data!.id_number,
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              !_status ? _getActionButtons() : Container(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Text("${snapshot.error}"),
            );
          }

          // By default, show a loading spinner.
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: Text("Edit",style: TextStyle(color: Colors.red,fontSize: 20),),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
 late BuildContext globalContext;
  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: TextButton(
                onPressed: () {  },
                child: Text("Save"),
                // textColor: Colors.white,
                // color: Colors.green,
                // onPressed: () {
                //   setState(() {
                //     final form = _formKey1.currentState;
                //     if (form!.validate()) {
                //       _status = true;
                //       pr.show();
                //       FocusScope.of(globalContext).requestFocus(new FocusNode());
                //       form.save();
                //       AuthenticationServices()
                //           .updateUser(
                //               first, last, email, phone, id, futureAlbum)
                //           .then((value) => {
                //              pr.hide(),
                //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //                   behavior: SnackBarBehavior.floating,
                //                   content: Text(value['message']),
                //                 )),
                //
                //               });
                //     } else {
                //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //         behavior: SnackBarBehavior.floating,
                //         content: Text('Make sure all the filds are filled'),
                //       ));
                //     }
                //   });
                // },
                // shape: new RoundedRectangleBorder(
                //     borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: Text("")

              //     Container(
              //   child: Text("Cancel"),
              //   textColor: Colors.white,
              //   color: Colors.red,
              //   onPressed: () {
              //     setState(() {
              //       _status = true;
              //       FocusScope.of(context).requestFocus(new FocusNode());
              //     });
              //   },
              //   shape: new RoundedRectangleBorder(
              //       borderRadius: new BorderRadius.circular(20.0)),
              // )

              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
