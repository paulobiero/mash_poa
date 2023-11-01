import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../Home/navigation_home_screen.dart';
import '../Services/AuthenticationServices.dart';
import '../Utils/Constants.dart';
import '../Utils/fade_animation.dart';
import 'OtpPage.dart';

class VerifyPhoneNumber extends StatefulWidget {
  const VerifyPhoneNumber({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumber();
}
class _VerifyPhoneNumber extends State<VerifyPhoneNumber> {
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
  late ProgressDialog pr;
  final FocusNode _field1 = FocusNode();
  final FocusNode _field2 = FocusNode();
  final FocusNode _field3 = FocusNode();
  final FocusNode _field4 = FocusNode();
  final formKey = new GlobalKey<FormState>();
  String _username='', _password='';
  bool _isHidden = true;
  void nextField({String? value, FocusNode? focus}) {
    if (value!.length == 1) {
      focus!.requestFocus();
    }
  }
  Widget field({FocusNode? focus, FocusNode? next, bool autofocus = false}) {
    return Container(

      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 1,
            offset: const Offset(0, 2),
            spreadRadius: 1)
      ], color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
      width: 64,
      height: 64,
      child: TextFormField(
          autofocus: autofocus,
          focusNode: focus,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
          onChanged: (e) {
            next != null ? nextField(value: e, focus: next) : null;
          },
          decoration:  InputDecoration(
              fillColor: Colors.yellow.shade700,
              border: OutlineInputBorder(borderSide: BorderSide.none))),
    );
  }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
      print("test " + _isHidden.toString());
    });
  }
  @override
  void dispose() {
    _field1.dispose();
    _field2.dispose();
    _field3.dispose();
    _field4.dispose();
    super.dispose();
  }
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  String text = '',password="",confirm_password="";
  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(text[position], style: TextStyle(color: Colors.black),)),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
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
                    colorFilter: new ColorFilter.mode(Colors.white.withOpacity(.7), BlendMode.dstATop),
                    image: AssetImage('assets/images/amani-nation-LTh5pGyvKAM-unsplash.jpg'),
                    fit: BoxFit.fill
                )
            ),
            child: Stack(
              clipBehavior: Clip.none, alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  height: 200,

                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(.6), BlendMode.dstATop),
                          image: AssetImage('assets/images/amani-nation-LTh5pGyvKAM-unsplash.jpg'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    children: <Widget>[

                      Positioned(
                        right: 10,
                        top: 80,
                        width: 300,
                        height: 150,
                        child:RichText(
                          text: TextSpan(
                            text: "Forgot",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),
                            children:  <TextSpan>[
                              TextSpan(text: ' Password ', style: TextStyle(fontWeight: FontWeight.bold,color:   Colors.blue.shade900)),

                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 180),
                  width:  double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),

                      borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight:Radius.circular(10) ),color: Colors.white
                  ),
                  child:
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Write correct phone number to continue',
                              style: GoogleFonts.inter(color: Colors.grey.shade700)),
                          const SizedBox(
                            height: 6,
                          ),
                          Form(
                            key: formKey,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(

                                    padding: EdgeInsets.only(top: 2.0,bottom: 2,left: 20),
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white70),
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Colors.grey.shade300
                                    ),
                                    child:InternationalPhoneNumberInput(
                                      onInputChanged: (PhoneNumber number) {
                                        print(number.phoneNumber);
                                      },
                                      countries: ['KE'],
                                      onInputValidated: (bool value) {
                                        print(value);
                                      },
                                      selectorConfig: SelectorConfig(
                                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                      ),
                                      ignoreBlank: false,
                                      autoValidateMode: AutovalidateMode.disabled,
                                      selectorTextStyle: TextStyle(color: Colors.black),
                                      initialValue: number,
                                      textFieldController: controller,
                                      formatInput: false,
                                      keyboardType:
                                      TextInputType.numberWithOptions(signed: true, decimal: true),
                                      inputBorder:InputBorder.none,
                                      onSaved: (PhoneNumber number) {
                                        print('On Saved: ${number.phoneNumber}');
                                        this.number=number;
                                      },inputDecoration:const InputDecoration(

                                        border: InputBorder.none,
                                        hintText: "Phone Number",
                                        hintStyle: TextStyle(color: Colors.black)
                                    ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 48,
                          ),

                          const SizedBox(
                            height: 12,
                          ),
                          FadeAnimation(
                            delay: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have an account? ',
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
                                  margin: EdgeInsets.only(top: size.height*.1),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color:   Colors.blue.shade900,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: Text('Continue',
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  )),onTap: (){
                              final form = formKey.currentState;
                              if (form!.validate()) {
                                form.save();
                                pr.show();
                                final Future<Map<String,dynamic>> successfulMessage =

                                AuthenticationServices().forgetPassword(controller.text);

                                pr.hide();
                                successfulMessage.then((response) {
                                 if(response['status'])
                                   {
                                     Navigator.pushReplacement(
                                       context,
                                       MaterialPageRoute<void>(
                                         builder: (BuildContext context) =>  OtpPage(title: controller.text,),

                                       ),

                                     );
                                   }else{

                                   ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                     behavior: SnackBarBehavior.floating,
                                     content: Text(response['message']),
                                     duration: Duration(seconds: 3),
                                   ));
                                 }
                                });
                              } else {
                                final snackBar=  SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("Please enter phone number"),
                                  duration: Duration(seconds: 3),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        )
    );
  }
}