import 'package:mash/AuthenticationPages/SignUp/OtpPage.dart';
import 'package:mash/Utils/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../Services/AuthenticationServices.dart';


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

  }
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
          decoration: const InputDecoration(
              fillColor: Colors.deepOrange,
              border: OutlineInputBorder(borderSide: BorderSide.none))),
    );
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
  String text = '';
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
                          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(.3), BlendMode.dstATop),
                          image: AssetImage('assets/images/amani-nation-LTh5pGyvKAM-unsplash.jpg'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    children: <Widget>[

                      Positioned(
                        right: 50,
                        top: 80,
                        width: 300,
                        height: 150,
                        child:RichText(
                          text: TextSpan(
                            text: "Create",
                            style: TextStyle(color: Colors.orange.shade700,fontWeight: FontWeight.bold,fontSize: 30),
                            children: const <TextSpan>[
                              TextSpan(text: ' Account ', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),

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
                            height: 96,
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
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
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

                          FadeAnimation(
                            delay: 600,
                            child: GestureDetector(
                              child: Container(
                                  height: 50,
                                  margin: EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.orange.shade700,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Text('Continue',
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600)),
                                  )),onTap: (){
                              final form = formKey.currentState;
                              if (form!.validate()) {
                                form.save();

                                final Future<Map<String,dynamic>> successfulMessage =
                                AuthenticationServices().createNewAccount(controller.text);


                                successfulMessage.then((response) {
                                  if(response['status'])
                                  {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>  OtpPage(title: controller.text,verificationKey: int.parse(response['verificationKey'].toString()),),

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
                                const snackBar=  const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("Please enter phone number"),
                                  duration: Duration(seconds: 3),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            },
                            ),
                          ),
                          const SizedBox(
                            height: 48,
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