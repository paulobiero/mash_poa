import 'package:mash/Models/TicketModel.dart';
import 'package:mash/Models/userInfo.dart';
import 'package:mash/Services/AuthenticationServices.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../Services/PaymentApiServices.dart';

class TicketFullDetails extends StatefulWidget {
  const TicketFullDetails({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final TicketModel title;

  @override
  State<TicketFullDetails> createState() => _TicketFullDetails();
}

class _TicketFullDetails extends State<TicketFullDetails> {
  late final ProgressDialog pr;

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

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(''),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      floatingActionButton: widget.title.status == "Pending"
          ? FloatingActionButton.extended(
              backgroundColor:  Colors.blue.shade900,
              foregroundColor: Colors.black,
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('New payment request'),
                        content: Container(
                          padding: const EdgeInsets.only(
                              top: 1.0, bottom: 1, left: 20),
                          margin: const EdgeInsets.only(top: 10, right: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(10)),
                              color: Colors.grey.shade200),
                          child: TextFormField(
                            validator: (value) => value!.isEmpty
                                ? "Please enter valid phone"
                                : null,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.phone),
                                hintText: "Phone number",
                                hintStyle: TextStyle(color: Colors.black)),
                            keyboardType: TextInputType.phone,
                            controller: _textEditingController,
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                // Close the dialog

                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () {
                                // Remove the box
                                Navigator.of(context).pop();
                                if (_textEditingController.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text("Please enter number"),
                                    duration: Duration(seconds: 3),
                                  ));
                                  return;
                                }
                                String sanitizedPhone = "";
                                String phone = _textEditingController.text;
                                if (phone.startsWith('254')) {
                                  sanitizedPhone = phone;
                                } else if (phone.startsWith("0")) {
                                  sanitizedPhone =
                                      '254${phone.substring(1, phone.length)}';
                                } else {
                                  sanitizedPhone = '254${phone}';
                                }
                                pr.show();
                                PaymentApiServices(context)
                                    .ReInitiatePayment(
                                        widget.title.booking_reference,
                                        double.parse(
                                                widget.title.payThroughMPesa)
                                            .toInt(),
                                        sanitizedPhone,
                                        false)
                                    .then((value) => {
                                          pr.hide(),
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                                "Make payment when prompted"),
                                            duration: Duration(seconds: 3),
                                          ))
                                        });
                              },
                              child: const Text('Submit')),
                        ],
                      );
                    });
                UserInfo userInfo = await AuthenticationServices().getUser();
                setState(() {
                  _textEditingController.text = userInfo.phone;
                });
              },
              icon: const Icon(
                Icons.currency_exchange,
                color: Colors.white,
              ),
              label: const Text(
                'New payment request',
                style: TextStyle(color: Colors.white),
              ),
            )
          : SizedBox(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Boarding Pass",
                textAlign: TextAlign.left,
                style: GoogleFonts.rubik(textStyle: headline4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "Ticket Number:${widget.title.ticket_number}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 800,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    height: 100,
                    child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Positioned(
                              top: 10,
                              left: 35,
                              right: 35,
                              child: Container(
                                  height: 50,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.yellow.shade50),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    color: Colors.yellow.shade50,
                                  ))),
                          Positioned(
                              top: 30,
                              left: 35,
                              right: 35,
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.yellow.shade100),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    color: Colors.yellow.shade100,
                                  ))),
                        ]),
                  ),
                  Positioned(
                      top: 50,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: 650,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow.shade200),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          color: Colors.yellow.shade200,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  widget.title.pickup_city
                                      .substring(0, 3)
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DottedLine(
                                  dashColor: Colors.grey.shade800,
                                  lineLength: 40,
                                  direction: Axis.horizontal,
                                ),
                                Icon(
                                  Icons.directions_bus_sharp,
                                  color: Colors.grey.shade800,
                                ),
                                DottedLine(
                                  dashColor: Colors.grey.shade800,
                                  lineLength: 40,
                                  direction: Axis.horizontal,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.title.drop_city
                                      .substring(0, 3)
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  child: Text(
                                    widget.title.pickup_city,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                  ),
                                  width: 100,
                                ),
                                Text(
                                  "${widget.title.total_amount} ${widget.title.currency_code} \n ${widget.title.status}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  child: Text(
                                    widget.title.drop_city,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                  ),
                                  width: 100,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                              width: 550,
                              child: Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Positioned(
                                      left: -10,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(300.0),
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DottedLine(
                                      dashColor: Colors.black,
                                      lineLength: size.width * .8,
                                      direction: Axis.horizontal,
                                    ),
                                    Positioned(
                                      right: -10,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(300.0),
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        widget.title.booking_date,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(widget.title.boarding_time,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade800),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.yellow.shade200,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Seat ${widget.title.seat_name}',
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        Text(
                                          "--,--,--",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(widget.title.arrival_time,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    width: 100,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: .2,
                              margin: const EdgeInsets.only(
                                  top: 30, right: 20, left: 20),
                              color: Colors.grey.shade700,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Expanded(
                                      child: Text(
                                    "Passenger ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Text(
                                    widget.title.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Expanded(
                                      child: Text(
                                    "Boarding time ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Text(
                                    widget.title.boarding_time,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Expanded(
                                      child: Text(
                                    "Boarding point ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Text(
                                    widget.title.boarding_point,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Expanded(
                                      child: Text(
                                    "Seat Name ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Text(
                                    widget.title.seat_name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Payment method",
                                        style: TextStyle(
                                            fontSize: size.width * 0.0255,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.title.payment_method,
                                        style: TextStyle(
                                            fontSize: size.width * 0.0255,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  DottedLine(
                                    dashColor: Colors.grey.shade800,
                                    lineLength: 20,
                                    direction: Axis.vertical,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Booking date",
                                        style: TextStyle(
                                            fontSize: size.width * 0.0255,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.title.booking_date,
                                        style: TextStyle(
                                            fontSize: size.width * 0.0255,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  DottedLine(
                                    dashColor: Colors.grey.shade800,
                                    lineLength: 20,
                                    direction: Axis.vertical,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Booking Ref",
                                        style: TextStyle(
                                            fontSize: size.width * 0.0255,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.title.booking_reference,
                                        style: TextStyle(
                                            fontSize: size.width * 0.0255,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20, left: 20),
                              child: Row(
                                children: [
                                  QrImage(
                                    data: widget.title.ticket_number,
                                    version: QrVersions.auto,
                                    size: 150.0,
                                  ),
                                  Text(widget.title.ticket_number)
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
