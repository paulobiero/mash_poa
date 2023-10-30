import 'package:mash/Models/BookingPassengerModel.dart';
import 'package:mash/Models/LocationItemModel.dart';
import 'package:mash/Models/SelectedSeatModel.dart';
import 'package:mash/Models/userInfo.dart';
import 'package:mash/Services/AuthenticationServices.dart';
import 'package:mash/Services/PaymentApiServices.dart';
import 'package:mash/Utils/Constants.dart';
import 'package:mash/Utils/UpperCaseTextFormatter.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'BookTicketBasePage.dart';

class PassengerInfo extends StatefulWidget {
  const PassengerInfo(
      {Key? key,
      required this.title,
      required this.buildContext,
      required this.onPageChanged,
      required this.seats,
      required this.from,
      required this.to})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final BuildContext buildContext;
  final Function(List<BookingPassengerModel>) onPageChanged;
  final List<SelectedSeatModel> seats;
  final LocationItemModel to, from;

  @override
  State<PassengerInfo> createState() => _PassengerInfo();
}

class _PassengerInfo extends State<PassengerInfo> {
  String email = "";
  UserInfo userInfo = UserInfo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // AuthenticationServices().getUser().then((value) => {
    // setState((){
    //   passengers.add(BookingPassengerModel(ticket_price: BookTicketBasePage.tripListModel.fares.first.price,first_name: value.name,last_name: value.last_name,phone: value.phone));
    //
    // })
    // });
    BookTicketBasePage.passengers.forEach((element) {
      BookingPassengerModel bookingPassengerModel = BookingPassengerModel(
          seatItem: element.seat, fareModel: element.fareModel);
      passengers.add(bookingPassengerModel);
    });
    AuthenticationServices().getUser().then((value) => {

          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: const Text('Travelling details'),
                  content:
                      const Text('Are you the one who is travelling?'),
                  actions: [
                    // The "Yes" button
                    TextButton(
                        onPressed: () {
                          // Close the dialog
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('No')),
                    TextButton(
                        onPressed: () {
                          // Remove the box
                          setState(() {
                            userInfo = value;
                            passengers[0].first_name =
                                userInfo.name.split(" ").first;
                            passengers[0].last_name =
                                userInfo.name.split(" ").last;
                            passengers[0].phone = userInfo.phone;
                            passengers[0].idNumber = userInfo.id_number;
                            email = userInfo.email;
                            BookTicketBasePage.email=email;
                            isLoading = false;
                          });

                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: const Text('Yes')),

                  ],
                );
              }),
        });
  }

  bool isLoading = true;
  final formKey = new GlobalKey<FormState>();
  List<BookingPassengerModel> passengers = [];

  bool validateTheForm(List<BookingPassengerModel> list) {
    var returnData = true;
    list.forEach((element) {
      print(element.toString());
      if (element.phone.isEmpty ||
          element.first_name.isEmpty ||
          element.last_name.isEmpty ||
          element.idNumber.isEmpty) {
        returnData = false;
      }
    });

    return returnData;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600);

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: GestureDetector(
          child: Container(
              height: 50,
              margin: EdgeInsets.only(left: 10, right: 10),
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.orange.shade800,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text('Make payment',
                    style: GoogleFonts.inter(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              )),
          onTap: () async {
            if (validateTheForm(passengers) && email.isNotEmpty) {
              PaymentApiServices paymentApiServices =
                  PaymentApiServices(context);
              widget.onPageChanged(passengers);
              BookTicketBasePage.email=email;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                content:
                    Text('Make sure all the required fields has been field'),
              ));
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: isLoading
            ? Column(
                children: [LinearProgressIndicator()],
              )
            : CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "Set passenger details",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.rubik(textStyle: headline4),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        "Seat is only reserved for 60 second until payment is confirmed",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Form(
                        child: Container(
                      padding: const EdgeInsets.only(top: 1.0, bottom: 1, left: 20),
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white70),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.shade300),
                      child: TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "Please enter valid email" : null,
                        onChanged: (s) {
                          email = s;
                        },
                        initialValue: userInfo.email,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.email),
                            hintText: "Email Address",
                            hintStyle: TextStyle(color: Colors.black)),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    )),
                    const SizedBox(height: 20.0),
                  ])),
                  passengers.isEmpty
                      ? SliverList(
                          delegate: SliverChildListDelegate([
                          SizedBox(
                            height: 100,
                          ),
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Text(
                                'No passenger has been added,add a passenger to continue',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ]))
                      : SliverList(
                          delegate: SliverChildListDelegate(passengers
                              .asMap()
                              .map((i, e) => MapEntry(
                                  i, bookingPassengerModelWidget(e, i, size)))
                              .values
                              .toList()))
                ],
              ));
  }

  Widget bookingPassengerModelWidget(
      BookingPassengerModel listModel, int index, Size size) {
    var items = [
      'Male',
      'Female',
    ];
    String dropDownValue = "Male";
    listModel.gendar = dropDownValue;

    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(
            top: 10,
            left: 20,
            right: 20,
            bottom: index == passengers.length - 1 ? 40 : 0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue.shade100,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blue.shade100,
          ),
          padding: EdgeInsets.only(top: 20.0, bottom: 1, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    index == 0
                        ? const Text(
                            "Primary passenger",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        : SizedBox(),
                    Text(
                      'Seat ${listModel.seatItem.seat_name}',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 1.0, bottom: 1, left: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    child: TextFormField(
                      onChanged: (s) {
                        listModel.first_name = s;
                      },
                      initialValue:listModel.first_name,
                      validator: (value) =>
                          value!.isEmpty ? "Please enter first name" : null,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.person),
                          hintText: "First name",
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                    width: size.width * .41,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 1.0, bottom: 1, left: 20),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    child: TextFormField(
                      onChanged: (s) {
                        listModel.last_name = s;
                      },
                      inputFormatters: <TextInputFormatter>[
                        UpperCaseTextFormatter()
                      ],
                      initialValue:listModel.last_name,
                      validator: (value) =>
                          value!.isEmpty ? "Please enter last name" : null,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.person),
                          hintText: "last name",
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                    width: size.width * .41,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 1.0, bottom: 1, left: 20),
                margin: const EdgeInsets.only(top: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(const Radius.circular(10)),
                    color: Colors.white),
                child: TextFormField(
                  initialValue: listModel.phone,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter valid phone" : null,
                  onChanged: (s) {
                    listModel.phone = s;
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.phone),
                      hintText: "Phone number",
                      hintStyle: TextStyle(color: Colors.black)),
                  keyboardType: TextInputType.phone,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 1.0, bottom: 1, left: 20),
                margin: const EdgeInsets.only(top: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: TextFormField(
                  initialValue: listModel.idNumber,
                  validator: (value) =>
                      value!.isEmpty ? "Please Id number" : null,
                  onChanged: (s) {
                    listModel.idNumber = s;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.numbers),
                    hintText: "Enter Id number",
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
