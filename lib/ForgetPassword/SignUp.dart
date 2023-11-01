import 'package:mash/AuthenticationPages/Login/Login.dart';
import 'package:mash/Services/AuthenticationServices.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../Home/navigation_home_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SignUpPage> createState() => _SignUpPage();
}
class _SignUpPage extends State<SignUpPage> {
  var items = [
    'Select gender',
    'Male',
    'Female',
  ];
  bool _isHidden = true;
  final formKey = new GlobalKey<FormState>();
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
      print("test " + _isHidden.toString());
    });
  }
  late ProgressDialog pr;
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
  String dropDownValue="Select gender";
  String firstName="",lastName="",dateOfBirth="",password="",confirm_password="",email="";
  final TextEditingController controller = TextEditingController();
  late DateTime newDate;
  @override
  Widget build(BuildContext context) {

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
                            text: "Forget",
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
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),

                      borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight:Radius.circular(10) ),color: Colors.white
                  ),
                  child:
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child:Form(
                      key: formKey,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                               Container(

                            padding: EdgeInsets.only(top: 1.0,bottom: 1,left: 20),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white70),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey.shade300
                            ),
                            child: TextFormField(
                              obscureText: _isHidden,
                              validator: (value) => value!.isEmpty ? "Please enter password" : null,

                              decoration: InputDecoration(
                                  suffixIcon:  IconButton(
                                    icon: Icon(
                                      _isHidden ? Icons.visibility_off : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                    onPressed: _togglePasswordView,
                                  ),
                                  border: InputBorder.none,
                                  icon: Icon(Icons.lock),
                                  hintText: "Enter Password",
                                  hintStyle: TextStyle(color: Colors.black)
                              ),
                              onSaved: (s){
                                password=s!;
                              },
                            ),
                          ),
                          Container(

                            padding: EdgeInsets.only(top: 1.0,bottom: 1,left: 20),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white70),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey.shade300
                            ),
                            child: TextFormField(
                              obscureText: _isHidden,
                              onSaved: (s){
                                confirm_password=s!;
                              },
                              validator: (value) => value!.isEmpty ? "Please confirm password" : null,

                              decoration: InputDecoration(
                                  suffixIcon:  IconButton(
                                    icon: Icon(
                                      _isHidden ? Icons.visibility_off : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                    onPressed: _togglePasswordView,
                                  ),
                                  border: InputBorder.none,
                                  icon: Icon(Icons.lock),
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(color: Colors.black)
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: (){
                              final form = formKey.currentState;
                              if (form!.validate()) {
                                form.save();
                                if(password!=confirm_password)
                                  {
                                    const snackBar=  SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text("Passwords do not match"),
                                      duration: Duration(seconds: 3),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                   return;
                                  }
                               pr.show();
                                AuthenticationServices().changePassword(widget.title, password,confirm_password).then((value) =>
                                {
                                pr.hide(),
                                  if(value['isSuccess'])
                                    {

                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(value['msg']),
                                  duration: Duration(seconds: 3),
                                )),
                              Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                              builder: (BuildContext context) => Login(title: ''),

                              ),

                              )
                                    }
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(value['msg']),
                                      duration: Duration(seconds: 3),
                                    ))
                                  }
                                });
                                print("the form has been completeed");
                              }
                              else{
                                print("the form incomplete");

                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                          Colors.blue.shade900,
                                          Colors.blue.shade900,
                                      ]
                                  )
                              ),
                              child: Center(
                                child: Text("Create new password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                          SizedBox(height: 50,),


                        ],
                      ),
                    ),
                  ),

                ),

              ],
            ),
          ),
        )
    );
  }
}