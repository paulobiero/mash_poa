import 'package:mash/AuthenticationPages/SignUp/OtpPage.dart';
import 'package:mash/Home/dashboard.dart';
import 'package:mash/Utils/UpperCaseTextFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Services/AuthenticationServices.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage(
      {Key? key, required this.title, required this.verificationKey})
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
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {

  late final ProgressDialog pr;
  bool _isHidden = true;
  final formKey = new GlobalKey<FormState>();

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
      print("test " + _isHidden.toString());
    });
  }

  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  var items = [
    'Male',
    'Female',
  ];
  String dropDownValue = "Male";
  String firstName = "",
      lastName = "",
      dateOfBirth = "",
      password = "",
      confirm_password = "",
      email = "";
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  late DateTime newDate;

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
                        left: size.width*.25,
                        top: 80,
                        width: 300,
                        height: 150,
                        child: RichText(
                          text: TextSpan(
                            text: "Create",
                            style: TextStyle(
                                color:  Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: ' Account ',
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
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 1.0, bottom: 1, left: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white70),
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(30)),
                                    color: Colors.grey.shade300),
                                child: TextFormField(
                                  onSaved: (s) {
                                    firstName = s!;
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    UpperCaseTextFormatter()
                                  ],
                                  textCapitalization: TextCapitalization.words,
                                  validator: (value) => value!.isEmpty
                                      ? "Please enter first name"
                                      : null,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.person),
                                      hintText: "First name",
                                      hintStyle:
                                          TextStyle(color: Colors.black)),
                                ),
                                width: size.width*.41,
                              ),
                              Container(
                                width: size.width*.41,
                                padding: EdgeInsets.only(
                                    top: 1.0, bottom: 1, left: 20),
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white70),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    color: Colors.grey.shade300),
                                child: TextFormField(
                                  onSaved: (s) {
                                    lastName = s!;
                                  },
                                  textCapitalization: TextCapitalization.words,
                                  inputFormatters: <TextInputFormatter>[
                                    UpperCaseTextFormatter()
                                  ],
                                  validator: (value) => value!.isEmpty
                                      ? "Please enter last name"
                                      : null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.person),
                                      hintText: "Last Name",
                                      hintStyle:
                                          TextStyle(color: Colors.black)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 2.0, bottom: 2, left: 20),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white70),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.grey.shade300),
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                print(number.phoneNumber);
                              },
                              countries: ['KE'],
                              onInputValidated: (bool value) {
                                print(value);
                              },
                              selectorConfig: SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle: TextStyle(color: Colors.black),
                              initialValue: number,
                              textFieldController: controller2,
                              formatInput: false,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              inputBorder: InputBorder.none,
                              onSaved: (PhoneNumber number) {
                                print('On Saved: ${number.phoneNumber}');
                                this.number = number;
                              },
                              inputDecoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Phone Number",
                                  hintStyle: TextStyle(color: Colors.black)),
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 1.0, bottom: 1, left: 20),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white70),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.grey.shade300),
                            child: TextFormField(
                              validator: (value) => value!.isEmpty
                                  ? "Please enter valid email"
                                  : null,
                              onSaved: (s) {
                                email = s!;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(Icons.email),
                                  hintText: "Email Address",
                                  hintStyle: TextStyle(color: Colors.black)),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 1.0, bottom: 1, left: 20),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white70),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.grey.shade300),
                            child: TextFormField(
                              controller: controller,
                              validator: (value) =>
                                  value!.isEmpty ? "Please enter DOB" : null,
                              onTap: () async {
                                newDate = (await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000, 11, 17),
                                  firstDate: DateTime(1900, 1),
                                  lastDate: DateTime(2022, 7),
                                  helpText: 'Select a date',
                                ))!;
                                setState(() {
                                  controller.text = (newDate.year.toString() +
                                      "-" +
                                      newDate.month.toString() +
                                      "-" +
                                      newDate.day.toString());
                                });
                              },
                              onSaved: (s) {
                                dateOfBirth = s!;
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.date_range),
                                hintText: "Date of birth",
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 1.0, bottom: 1, left: 20, right: 10),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white70),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.grey.shade300),
                            child: DropdownButton(
                              // Initial Value
                              value: dropDownValue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownValue = newValue!;
                                });
                                print("the value is $dropDownValue");
                              },
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 1.0, bottom: 1, left: 20),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white70),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.grey.shade300),
                            child: TextFormField(
                              obscureText: _isHidden,
                              validator: (value) => value!.isEmpty
                                  ? "Please enter password"
                                  : null,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                    onPressed: _togglePasswordView,
                                  ),
                                  border: InputBorder.none,
                                  icon: Icon(Icons.lock),
                                  hintText: "Enter Password",
                                  hintStyle: TextStyle(color: Colors.black)),
                              onSaved: (s) {
                                password = s!;
                              },
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 1.0, bottom: 1, left: 20),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white70),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.grey.shade300),
                            child: TextFormField(
                              obscureText: _isHidden,
                              onSaved: (s) {
                                confirm_password = s!;
                              },
                              validator: (value) => value!.isEmpty
                                  ? "Please confirm password"
                                  : null,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                    onPressed: _togglePasswordView,
                                  ),
                                  border: InputBorder.none,
                                  icon: Icon(Icons.lock),
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(color: Colors.black)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              final form = formKey.currentState;
                              if (form!.validate()) {
                                form.save();
                                if (controller2.text.isEmpty ||
                                    controller2.text.length != 9) {
                                  const snackBar = SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text("Add a valid phone number"),
                                    duration: Duration(seconds: 3),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  return;
                                }
                                if (password != confirm_password) {
                                  const snackBar = SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text("Passwords do not match"),
                                    duration: Duration(seconds: 3),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  return;
                                }
                                if (dropDownValue == "Select Gender") {
                                  const snackBar = SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text("Please select gender"),
                                    duration: Duration(seconds: 3),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  return;
                                }
                                pr.show();
                                AuthenticationServices()
                                    .createUserProfile(
                                        firstName,
                                        lastName,
                                        controller2.text,
                                        email,
                                        dateOfBirth,
                                        dropDownValue,
                                        password,
                                        widget.verificationKey)
                                    .then((value) => {
                                          if (value['status'])
                                            {
                                              pr.hide(),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(value['message']),
                                                duration:
                                                    const Duration(seconds: 3),
                                              )),
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext context) =>
                                                     OtpPage(title: controller2.text, verificationKey: 0),
                                                  ),(route) => false
                                              )
                                            }
                                          else
                                            {
                                              pr.hide(),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(value['message']),
                                                duration:
                                                    const Duration(seconds: 3),
                                              ))
                                            }
                                        });
                                print("the form has been completeed");
                              } else {
                                print("the form incomplete");
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(colors: [
                                     Colors.green.shade700,
                                     Colors.green.shade700,
                                  ])),
                              child: const Center(
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
