import 'package:mash/About/Dialogs/ContactUs.dart';
import 'package:mash/About/Dialogs/PrivacyPolicy.dart';
import 'package:mash/AuthenticationPages/Login/Login.dart';
import 'package:mash/AuthenticationPages/SignUp/OtpPage.dart';
import 'package:mash/AuthenticationPages/SignUp/SignUp.dart';
import 'package:mash/Models/AboutItem.dart';
import 'package:flutter/material.dart';

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/Utils/Constants.dart';

import 'Dialogs/AboutUs.dart';
import 'Dialogs/TermsAndConditions.dart';

class AboutLandingPage extends StatefulWidget {
  const AboutLandingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AboutLandingPage createState() => _AboutLandingPage();
}

class _AboutLandingPage extends State<AboutLandingPage> {
  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => Login(
              title: '',
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        margin: const EdgeInsets.only(left: 30, right: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: <BoxShadow>[],
            color: Colors.yellow.shade700),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      items.add(AboutItem(
          name: "About ${AppUrl.companyName}",
          content: "Learn more about ${AppUrl.companyName}",
          icon: const Icon(Icons.info),
          onClick: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AboutUs(title: '',),
                fullscreenDialog: true,
              ),
            );
          }));
      items.add(AboutItem(
          name: "Terms and conditions",
          content: "Rules to follow while using ${AppUrl.companyName}",
          icon: const Icon(Icons.receipt_long),
          onClick: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => TermsAndConditions(title: '',),
                fullscreenDialog: true,
              ),
            );
          }));
      items.add(AboutItem(
          name: "Privacy Policy",
          content: "Learn how your data is handled on ${AppUrl.companyName}",
          icon: const Icon(Icons.receipt),
          onClick: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => PrivacyPolicy(title: '',),
                fullscreenDialog: true,
              ),
            );
          }));
      items.add(AboutItem(
          name: "Contact Us",
          content: "Want to reach out to us?",
          icon: const Icon(Icons.phone),
          onClick: () {

            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ContactUs(title: '',),
                fullscreenDialog: true,
              ),
            );
          }));
    });
  }

  List<AboutItem> items = [];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size;
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w600
    );
    final TextStyle ticketLargeText=Theme.of(context).textTheme.headline2!.copyWith(
      color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)),
      body:

      CustomScrollView(
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate([
            Padding(padding: EdgeInsets.only(left: 20,top: 20)
              ,child:  Text(
                "About Us",
                textAlign: TextAlign.left,
                style:GoogleFonts.rubik(textStyle: headline4),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 20,top: 10),child:   Text(
              "Learn more about us",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
              textAlign: TextAlign.left,
            ),),

            SizedBox(height: 20,),

          ])),
          SliverList(delegate: SliverChildListDelegate(items.map((item) => ListTile(
            title: Text(item.name),
            subtitle: Text(item.content),
            leading: item.icon,
            trailing: const Icon(Icons.chevron_right),
            onTap: item.onClick,
          )).toList())),
        ])

     ,
    );
  }
}
