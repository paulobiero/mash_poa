import 'dart:async';

import 'package:mash/BookTicket/BookTicketBasePage.dart';
import 'package:mash/Models/LocationItemModel.dart';
import 'package:mash/Services/PaymentApiServices.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rich_alert/rich_alert.dart';
import '../Services/GetListData.dart';

class ChoosePaymentMethod extends StatefulWidget {
  const ChoosePaymentMethod(
      {Key? key,
      required this.title,
      required this.buildContext,
      required this.from,
      required this.to,
      required this.onPaymentChosen,
      required this.widget})
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
  final Function(String) onPaymentChosen;
  final LocationItemModel from, to;
  final BookTicketBasePage widget;

  @override
  State<ChoosePaymentMethod> createState() => _ChoosePaymentMethod();
}

class _ChoosePaymentMethod extends State<ChoosePaymentMethod> {
  bool isLoading = true;
  bool isSuccess = true;
  List<String> paymentMethods = [];
  late final ProgressDialog pr;
  late CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  var selected = false;
  int paymentRequired = 0;

  Widget buildItem(String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return page;
        }));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        color: Colors.blue,
        width: double.infinity,
        alignment: Alignment.center,
        height: 100,
        child: Text(
          title,
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }

  late Timer _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            handleTimeout();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  int walletAmount = 0, totalAmount = 0;
  String selectedPaymentMethod="";
  @override
  void initState() {
    PaymentApiServices apiServices = PaymentApiServices(context);
    apiServices.getWalletData().then((val) => {
          GetListData(widget.buildContext).getPaymentMethods().then((value) => {
                print("the values are $value"),
                setState(() {
                  paymentMethods = value;
                  isLoading = false;
                  try{
                    walletAmount = double.parse(val[0]["amount"]).toInt();
                  }catch(r){
                    walletAmount=0;
                  }
                })
              })
        });
    int total = 0;
    BookTicketBasePage.passengers.forEach((element) {
      total += double.parse(element.fareModel.amount).toInt();
    });
    setState(() {
      paymentRequired = total;
      totalAmount = total;
    });
    super.initState();
    Timer scheduleTimeout([int milliseconds = 10000]) =>
        Timer(Duration(milliseconds: milliseconds), handleTimeout);
    scheduleTimeout(60 * 1000);
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );
    pr.style(message: "Please wait");
  }

  void handleTimeout() {
    // callback function
    // Do some work.
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600);

    final TextStyle ticketLargeText =
        Theme.of(context).textTheme.headline2!.copyWith(
              color: Colors.grey.shade800,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            );
    final SimpleDialog dialog2 = SimpleDialog(
      title: Text('Choose payment method'),
      children: paymentMethods
          .map((e) => ListTile(
                title: Text(e),
                onTap: () {
                  Navigator.pop(context);
                  widget.onPaymentChosen(e);
                },
              ))
          .toList(),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Column(
              children: const [LinearProgressIndicator()],
            )
          : CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      isSuccess
                          ? "Pay ${paymentRequired} KSH"
                          : "Ticket booked",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.rubik(textStyle: headline4),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      isSuccess
                          ? "Make payment to reserve a seat?"
                          : "Ticket reserved for 15 minutes",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey),
                      textAlign: TextAlign.left,
                    ),
                  ),
                      GestureDetector(
                        child: Container(
                          width: 200,
                          height: 80,
                          margin: const EdgeInsets.only(top: 35, right: 20, left: 20),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: selected?Colors.orange.shade700:Colors.grey.shade400,width: selected?2:1),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20,top: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "my wallet".toUpperCase(),
                                        style: GoogleFonts.rubik(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(selected
                                          ? "$walletAmount KSH from wallet applied"
                                          : 'Apply wallet $walletAmount KSH',style: GoogleFonts.rubik(color: Colors.black,fontWeight: FontWeight.w500),)
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Image.asset(
                                  'assets/images/—Pngtree—3d coins and banknotes in_8388570.png',
                                  fit: BoxFit.cover,
                                  height: 80,
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {

                          setState(() {
                            selected = !selected;
                            print("The current state is $selected");
                            if (selected) {
                              if (walletAmount >= totalAmount) {
                                paymentRequired = 0;
                              } else {
                                paymentRequired = totalAmount - walletAmount;
                              }
                            } else {
                              paymentRequired = totalAmount;
                            }
                          });
                        },
                      ),
                ])),
                isSuccess
                    ? SliverList(
                        delegate: SliverChildListDelegate(paymentMethods
                            .map((e) => getPaymentWidget(e))
                            .toList()))
                    : SliverList(
                        delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/on_4847186.png',
                                height: 130,
                                fit: BoxFit.cover,
                                color: Colors.grey.shade400,
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      'Your ticket has been booked successfully,confirming payment in \n',
                                  style: ticketLargeText,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '$_start seconds',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const TextSpan(text: ' !'),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      ])),
                SliverList(
                    delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      if(selectedPaymentMethod.isNotEmpty)
                        {
                          pr.show();
                          var baseCont = context;
                          PaymentApiServices(context)
                              .ticketBooking(
                              BookTicketBasePage.bookings,
                              BookTicketBasePage.tripListModel,
                              widget.from,
                              widget.to,
                              BookTicketBasePage.pickLocation,
                              BookTicketBasePage.dropLocation,
                              widget.title,
                              BookTicketBasePage.email,
                              selected,
                              paymentRequired)
                              .then((value) => {
                            if (value['status'] == false)
                              {
                                pr.hide(),
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return RichAlertDialog(
                                        alertTitle: richTitle("Booking Error"),
                                        alertSubtitle: richSubtitle(value['message']),
                                        alertType: RichAlertType.ERROR,
                                        actions: <Widget>[
                                          GestureDetector(
                                            child: Container(
                                                height: 50,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    color: Colors.red.shade800,
                                                    borderRadius:
                                                    BorderRadius.circular(10)),
                                                child: Center(
                                                  child: Text('Okay',
                                                      style: GoogleFonts.inter(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w600)),
                                                )),
                                            onTap: () async {
                                              Navigator.pop(context);
                                              Navigator.pop(baseCont);
                                            },
                                          )
                                        ],
                                      );
                                    })
                              }
                            else
                              {
                                PaymentApiServices(context)
                                    .initiatePayment(value['booking_reference'],
                                    totalAmount, value['phone'], selected)
                                    .then((val) => {
                                  pr.hide(),
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return RichAlertDialog(
                                            alertTitle: richTitle(
                                                paymentRequired == 0
                                                    ? "Booking successfully"
                                                    : "Reservation Successful"),
                                            alertSubtitle: richSubtitle(
                                                paymentRequired == 0
                                                    ? "You have successfully booked your tickets"
                                                    : 'Please complete your payment to complete your booking'),
                                            alertType: RichAlertType.SUCCESS,
                                            actions: <Widget>[
                                              GestureDetector(
                                                child: Container(
                                                    height: 50,
                                                    width: 300,
                                                    margin: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                        Colors.green.shade500,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                    child: Center(
                                                      child: Text('Okay',
                                                          style:
                                                          GoogleFonts.inter(
                                                              color: Colors
                                                                  .white,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600)),
                                                    )),
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  Navigator.pop(baseCont);
                                                  widget.widget.onPageChanged();
                                                },
                                              )
                                            ]);
                                      })
                                })
                              }
                          });
                        }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*.9,
                      margin: const EdgeInsets.only(left: 20,right: 20,top: 30),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          boxShadow: const <BoxShadow>[],
                          color:selectedPaymentMethod.isNotEmpty? Colors.orange.shade700:Colors.grey.shade200),
                      child:  Text(
                        'Make payment',
                        style: TextStyle(
                            fontSize: 20, color:selectedPaymentMethod.isNotEmpty? Colors.white:Colors.grey.shade500, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 30, bottom: 20),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      // showDialog<void>(context: context, builder: (context) => dialog2);
                    },
                  )
                ]))
              ],
            ),
    );
  }

  Widget getPaymentWidget(String e) {
    return GestureDetector(
      child: Container(
        width: 200,
        height: 80,
        margin: EdgeInsets.only(top: 15, right: 20, left: 20),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color:selectedPaymentMethod==e?Colors.orange.shade700: Colors.grey.shade400,width: selectedPaymentMethod==e?2:1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  e.toUpperCase(),
                  style: GoogleFonts.rubik(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Image.asset(
                'assets/images/M-PESA-removebg-preview.png',
                fit: BoxFit.cover,
                height: 35,
              ),
            )
          ],
        ),
      ),
      onTap: () {
      setState(() {
        selectedPaymentMethod=e;
      });
      },
    );
  }
}
