import 'package:mash/AuthenticationPages/Login/Login.dart';
import 'package:mash/AuthenticationPages/SignUp/OtpPage.dart';
import 'package:mash/AuthenticationPages/SignUp/SignUp.dart';
import 'package:flutter/material.dart';

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class AuthLandingPage extends StatefulWidget {
  const AuthLandingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AuthLandingPage createState() => _AuthLandingPage();
}

class _AuthLandingPage extends State<AuthLandingPage> {

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>  Login(title: '',),

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
            color:  Colors.blue.shade900),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _signUp() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>  SignUpPage(title: '', verificationKey: 0,),

          ),

        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        margin: const EdgeInsets.only(left: 30, right: 30),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: <BoxShadow>[],
            color: Colors.black),
        child: const Text(
          'Register',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(.5), BlendMode.dstATop),
                  image: const AssetImage(
                      'assets/images/amani-nation-LTh5pGyvKAM-unsplash.jpg'),
                  fit: BoxFit.fill)),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                    width: 130,
                    height: 130,
                    top: 100,
                    left: height.width * .32,
                    child: Container(
                      decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                          boxShadow: <BoxShadow>[],
                          color: Colors.white),
                      padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 30,
                      ) ,
                    )),
                Positioned(
                    top: height.height * .56,
                    height: height.height * .6,
                    width: height.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipPath(
                          clipper: WaveClipperTwo(reverse: true, flip: true),
                          child: Container(
                            height: 100,
                            color: Colors.white,
                            child: const Text(""),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .4,
                          color: Colors.white,
                          child: Column(
                            children: [
                              _submitButton(),
                              const SizedBox(
                                height: 10,
                              ),
                              _signUp(),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'By continuing you have accepted our ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const Text(
                                'Terms and conditions',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                               SizedBox(
                                height: height.height*.005,
                              ),
                              SizedBox(
                                width: 250,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Powered by",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13),
                                    ),
                                    SizedBox(width: 10,),
                                    Image.asset(
                                      'assets/images/ic_action_name.png',
                                      height: 30,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                Positioned(
                    width: 200,
                    height: 200,
                    top: height.height * .40,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/Snapinsta.app_168504960_2146600465482288_3369342487551145619_n_1080-removebg-preview.png'))),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
