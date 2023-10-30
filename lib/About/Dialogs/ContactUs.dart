import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  ContactUs({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ContactUs createState() => _ContactUs();
}

class _ContactUs extends State<ContactUs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String bullet = "\u2022 ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Contact Us",
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
                  "Head Office",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.only(top: 20, left: 20, right: 10),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text("TRANSLINE CLASSIC LTD",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text("Head office,Nairobi",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "OLA Service station next to Afya center building Along Tom Mboya Avenue",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                  child: GestureDetector(
                    child: RichText(
                      text: TextSpan(
                        text: 'Email us at :',
                        style:
                        GoogleFonts.rubik(fontSize: 15, color: Colors.black),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'translineclassic20@gmail.com',
                              style: TextStyle(color: Colors.blue)),
                        ],
                      ),
                    ),
                    onTap: ()async{
                      var url = Uri.parse("mailto:translineclassic20@gmail.com");
                      if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                      } else {
                      throw 'Could not launch $url';
                      }
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Text("For Booking Telephone :",
                    style: GoogleFonts.rubik(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                  child: GestureDetector(
                    child: Text("$bullet 0720255355",
                        style: GoogleFonts.rubik(
                            fontSize: 15, color: Colors.blue)),
                    onTap: () async {
                      var url = Uri.parse("tel:0720255355");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                  child: GestureDetector(
                    child: Text("$bullet 0720255355",
                        style: GoogleFonts.rubik(
                            fontSize: 15, color: Colors.blue)),
                    onTap: () async {
                      var url = Uri.parse("tel:0720255355");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                  child: GestureDetector(
                    child: Text("$bullet 0794837330",
                        style: GoogleFonts.rubik(
                            fontSize: 15, color: Colors.blue)),
                    onTap: () async {
                      var url = Uri.parse("tel:0794837330");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  )),
              Form(
                  child: Card(
                elevation: 2,
                margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.yellow.shade100,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.yellow.shade100,
                  ),
                  padding: EdgeInsets.only(top: 10.0, bottom: 1, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                            top: 1.0, bottom: 1, left: 20),
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? "Please enter name" : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.person),
                            hintText: "Enter name",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 2.0, bottom: 2, left: 20),
                        margin: EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white70),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: InternationalPhoneNumberInput(
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
                          formatInput: false,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputBorder: InputBorder.none,
                          onSaved: (PhoneNumber number) {},
                          inputDecoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone Number",
                              hintStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 1.0, bottom: 1, left: 20),
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? "Please email address" : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.email),
                            hintText: "Enter Id number",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 1.0, bottom: 1, left: 20),
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? "Please enter subject" : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.subject),
                            hintText: "Enter subject",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 1.0, bottom: 1, left: 20),
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? "Please enter message" : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.message),
                            hintText: "Enter message",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10, top: 30),
                        child: SizedBox(
                            height: 40.0,
                            child: GestureDetector(
                              child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text('Submit',
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  )),
                              onTap: () async {},
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
