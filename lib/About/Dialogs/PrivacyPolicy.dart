import 'dart:convert';

import 'package:mash/Models/userInfo.dart';
import 'package:mash/Services/AuthenticationServices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:progress_dialog/progress_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _PrivacyPolicy createState() => _PrivacyPolicy();
}

class _PrivacyPolicy extends State<PrivacyPolicy> {
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
            "Privacy Policy",
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
                  "PRIVACY POLICY",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                padding: EdgeInsets.only(top: 20,right: 20,left: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "The Internet is an amazing tool. It has the power to change the way we live, and we're starting to see that potential today. With only a few mouse-clicks, you can follow the news, look up facts, buy goods and services, and communicate with others from around the world. It's important to Tahmeed Coach to help our customers retain their privacy when they take advantage of all the Internet has to offer.We believe your business is no one else's. Your privacy is important to you and to us. So we'll protect the information you share with us. To protect your privacy, Tahmeed Coach follows different principles in accordance with worldwide practices for customer privacy and data protection",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 40),
                child: Text("$bullet We won’t sell or give away your name, mail address, phone number, email address or any other information to anyone",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 40),
                child: Text(
                    "$bullet We’ll use state-of-the-art security measures to protect your information from unauthorized users",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),

              const Padding(
                child: Text(
                  "NOTICE",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                padding: EdgeInsets.only(top: 20,right: 20,left: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "We will ask you when we need information that personally identifies you (personal information) or allows us to contact you. Generally, this information is requested when you create a Registration ID on the site or when you download free software, enter a contest, order email newsletters or join a limited-access premium site. We use your Personal Information for four primary purposes",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 40),
                child: Text("$bullet To make the site easier for you to use by not having to enter information more than once",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 40),
                child: Text(
                    "$bullet To help you quickly find software, services or information",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 40),
                child: Text(
                    "$bullet To help us create content most relevant to you",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20, left: 40),
                child: Text(
                    "$bullet To alert you to product upgrades, special offers, updated information and other new services from Tahmeed Coach",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),

              const Padding(
                child: Text(
                  "SECURITY",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                padding: EdgeInsets.only(top: 20,right: 20,left: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "Tahmeed Coach has taken strong measures to protect the security of your personal information and to ensure that your choices for its intended use are honored. We take strong precautions to protect your data from loss, misuse, unauthorized access or disclosure, alteration, or destruction.We guarantee your e-commerce transactions to be 100% safe and secure. When you place orders or access your personal account information, you're utilizing secure server software SSL, which encrypts your personal information before it's sent over the Internet. SSL is one of the safest encryption technologies available.Tahmeed Coach strictly protects the security of your personal information and honors your choices for its intended use. We carefully protect your data from loss, misuse, unauthorized access or disclosure, alteration, or destruction.Your personal information is never shared outside the company without your permission, except under conditions explained above. Inside the company, data is stored in password-controlled servers with limited access. Your information may be stored and processed in Kenya or any other country where TRANSLINE CLASSIC LTD, its subsidiaries, affiliates or agents are located.You also have a significant role in protecting your information. No one can see or edit your personal information without knowing your user name and password, so do not share these with others",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),

              const Padding(
                child: Text(
                  "NOTICE TO PARENTS",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                padding: EdgeInsets.only(top: 20,right: 20,left: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "Parents or guardians: we want to help you guard your children's privacy. We encourage you to talk to your children about safe and responsible use of their Personal Information while using the Internet.The Tahmeed Coach site does not publish content that is targeted to children. However, if you are concerned about your children providing Tahmeed Coach any personal information without your consent, Tahmeed Coach offers a Kids account. It allows parents to give parental consent for the collection, use and sharing of childrenâ€™s (ages 12 and under) personal information online.",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),

              const Padding(
                child: Text(
                  "ENFORCEMENT",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                padding: EdgeInsets.only(top: 20,right: 20,left: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "If for some reason you believe Tahmeed Coach has not adhered to these principles, please notify us by email at info@mashpoa.com, and we will do our best to determine and correct the problem promptly. Be certain the words Privacy Policy are in the Subject line.",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),

              const Padding(
                child: Text(
                  "ELECTRONIC PRODUCT REGISTRATION",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                padding: EdgeInsets.only(top: 20,right: 20,left: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "When you buy and install a new product, we may ask you to register your purchase electronically. When you do, we merge your registration information with any information you've already left with us (we call that information your personal profile). If you haven't previously registered with us, we create a personal profile for you from your product registration information. If you ever want to review or update that information, you can visit the Profile Center, click on Update Profile, and edit any of the Personal Information in your profile. If you haven't already created a Registration ID, we will ask you to do so. This ensures that only you can access your information.",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),

              const Padding(
                child: Text(
                  "CUSTOMER PROFILES",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                padding: EdgeInsets.only(top: 20,right: 20,left: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "As mentioned above, every registered customer has a unique personal profile. Each profile is assigned a unique personal identification number, which helps us ensure that only you can access your profile.When you register, we create your profile, assign a personal identification number, then send this personal identification number back to your hard drive in the form of a cookie, which is a very small bit of code. This code is uniquely yours. It is your passport to seamless travel across [http://translineclassic.com], allowing you to download free software, order free newsletters, and visit premium sites without having to fill out registration forms with information you've already provided. Even if you switch computers, you won't have to re-register just use your Registration ID to identify yourself.",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),

              const Padding(
                child: Text(
                  "WHAT WE DO WITH THE INFORMATION YOU SHARE",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                padding: EdgeInsets.only(top: 20,right: 20,left: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "When you join us, you provide us with your contact information, including Names, Phone Numbers, Age, Sex, ID Number and email address. We use this information to send you updates about your order, questionnaires to measure your satisfaction with our service and announcements about new and exciting services that we offer. When you order from us, we ask for your credit card number and billing address. We use this information only to bill you for the product(s) you order at that time. For your convenience, we do save billing information in case you want to order from us again, but we don't use this information again without your permission.We occasionally hire other companies to provide limited services on our behalf, including packaging, mailing and delivering purchases, answering customer questions about products or services, sending postal mail and processing event registration. We will only provide those companies the information they need to deliver the service, and they are prohibited from using that information for any other purpose.",
                    style: GoogleFonts.rubik(fontSize: 15)),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Text(
                    "Tahmeed Coach will disclose your personal information, without notice, only if required to do so by law or in the good faith belief that such action is necessary to: (a) conform to the edicts of the law or comply with legal process served on Tahmeed Coach or the site; (b) protect and defend the rights or property of Tahmeed Coach and its family of Websites, and, (c) act in urgent circumstances to protect the personal safety of users of Tahmeed Coach, its Websites, or the public",
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
