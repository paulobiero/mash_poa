import 'package:mash/Utils/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../Home/dashboard.dart';
import '../../Services/AuthenticationServices.dart';
import '../SignUp/SignUp.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key, required this.title, required this.verificationKey})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final int verificationKey;

  @override
  State<OtpPage> createState() => _OtpPage();
}

class _OtpPage extends State<OtpPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );
    pr.style(message: "Please wait");
  }

  final FocusNode _field1 = FocusNode();
  final FocusNode _field2 = FocusNode();
  final FocusNode _field3 = FocusNode();
  final FocusNode _field4 = FocusNode();
  final FocusNode _field5 = FocusNode();
  final FocusNode _field6 = FocusNode();
  final formKey = new GlobalKey<FormState>();
  String _username = '', _password = '';
  bool _isHidden = true;
  late final ProgressDialog pr;

  void nextField({String? value, FocusNode? focus}) {
    if (value!.length == 1) {
      focus!.requestFocus();
    }
  }

  Widget field(
      {FocusNode? focus,
      FocusNode? next,
      bool autofocus = false,
      required void Function(String?) onSaved}) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 1,
            offset: const Offset(0, 2),
            spreadRadius: 1)
      ], color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
      width: 50,
      height: 50,
      child: TextFormField(
          autofocus: autofocus,
          focusNode: focus,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onSaved: onSaved,
          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
          onChanged: (e) {
            next != null ? nextField(value: e, focus: next) : null;
          },
          decoration: InputDecoration(
              fillColor: Colors.yellow.shade700,
              border: OutlineInputBorder(borderSide: BorderSide.none))),
    );
  }

  @override
  void dispose() {
    _field1.dispose();
    _field2.dispose();
    _field3.dispose();
    _field4.dispose();
    _field5.dispose();
    _field6.dispose();
    super.dispose();
  }

  String text = '',
      text1 = '',
      text2 = '',
      text3 = '',
      text4 = '',
      text5 = '',
      text6 = '';

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          text[position],
          style: TextStyle(color: Colors.black),
        )),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.white.withOpacity(.7), BlendMode.dstATop),
                    image: AssetImage(
                        'assets/images/amani-nation-LTh5pGyvKAM-unsplash.jpg'),
                    fit: BoxFit.fill)),
            child: Stack(
              clipBehavior: Clip.none, alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(.3), BlendMode.dstATop),
                          image: AssetImage(
                              'assets/images/amani-nation-LTh5pGyvKAM-unsplash.jpg'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: size.width * .25,
                        top: 80,
                        width: 300,
                        height: 150,
                        child: RichText(
                          text: TextSpan(
                            text: "Confirm",
                            style: TextStyle(
                                color: Colors.yellow.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: ' OTP ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 180),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('The OTP has been sent to +254${widget.title}',
                              style: GoogleFonts.inter(
                                  color: Colors.grey.shade700)),
                          const SizedBox(
                            height: 96,
                          ),
                          Form(
                              key: formKey,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FadeAnimation(
                                      delay: 200,
                                      child: field(
                                          focus: _field1,
                                          next: _field2,
                                          autofocus: true,
                                          onSaved: (s) {
                                            setState(() {
                                              text1 = s!;
                                            });
                                          })),
                                  FadeAnimation(
                                      delay: 400,
                                      child: field(
                                          focus: _field2,
                                          next: _field3,
                                          onSaved: (s) {
                                            setState(() {
                                              text2 = s!;
                                            });
                                          })),
                                  FadeAnimation(
                                      delay: 600,
                                      child: field(
                                          focus: _field3,
                                          next: _field4,
                                          onSaved: (s) {
                                            setState(() {
                                              text3 = s!;
                                            });
                                          })),
                                  FadeAnimation(
                                      delay: 800,
                                      child: field(
                                          focus: _field4,
                                          next: _field5,
                                          onSaved: (s) {
                                            setState(() {
                                              text4 = s!;
                                            });
                                          })),
                                  FadeAnimation(
                                      delay: 1000,
                                      child: field(
                                          focus: _field5,
                                          next: _field6,
                                          onSaved: (s) {
                                            setState(() {
                                              text5 = s!;
                                            });
                                          })),
                                  FadeAnimation(
                                      delay: 1200,
                                      child: field(
                                          focus: _field6,
                                          onSaved: (s) {
                                            setState(() {
                                              text6 = s!;
                                            });
                                          })),
                                ],
                              )),
                          const SizedBox(
                            height: 48,
                          ),
                          FadeAnimation(
                            delay: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Didn\'t receive code? ',
                                    style: GoogleFonts.inter(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500)),
                                GestureDetector(
                                  onTap: () {
                                    pr.show();
                                    AuthenticationServices().resendOTP(widget.title).then((value) =>
                                    {
                                      pr.hide(),
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(
                                            behavior:
                                            SnackBarBehavior.floating,
                                            content: Text(
                                                value['message']),
                                            duration:
                                            const Duration(seconds: 3),
                                          ))
                                    });
                                  },
                                  child: Text('Request again',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500)),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          FadeAnimation(
                            delay: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Wrong mobile number? ',
                                    style: GoogleFonts.inter(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Go to login',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500)),
                                )
                              ],
                            ),
                          ),
                          FadeAnimation(
                            delay: 600,
                            child: GestureDetector(
                              child: Container(
                                  height: 50,
                                  margin:
                                      EdgeInsets.only(top: size.height * .1),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow.shade700,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Text('Continue',
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600)),
                                  )),
                              onTap: () {
                                final form = formKey.currentState;
                                if (form!.validate()) {
                                  form.save();
                                  String texts = text1 +
                                      text2 +
                                      text3 +
                                      text4 +
                                      text5 +
                                      text6;
                                  pr.show();
                                  AuthenticationServices()
                                      .verifyOTP(widget.title, texts,
                                          widget.verificationKey)
                                      .then((value) => {
                                            if (value['status'])
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                      "OTP successfully verified"),
                                                  duration:
                                                      Duration(seconds: 3),
                                                )),
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const Dashboard(),
                                                    ),
                                                    (route) => false)
                                              }
                                            else
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                      "OTP verification Error,use the correct OTP"),
                                                  duration:
                                                      Duration(seconds: 3),
                                                ))
                                              }
                                          });
                                }
                              },
                            ),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
