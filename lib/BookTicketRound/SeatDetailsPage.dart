import 'package:mash/Models/BookingPassengerModel.dart';
import 'package:mash/Models/FaresModel.dart';
import 'package:mash/Models/LocationItemModel.dart';
import 'package:mash/Models/SeatItem.dart';
import 'package:mash/Models/SelectedSeatModel.dart';
import 'package:mash/Models/TripListModel.dart';
import 'package:mash/Services/GetListData.dart';
import 'package:mash/Utils/Constants.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'BookTicketBasePage.dart';
import 'dart:math' as math;

class SeatDetailsPage extends StatefulWidget {
  const SeatDetailsPage({
    Key? key,
    required this.title,
    required this.buildContext,
    required this.onPageChanged,
    required this.from,
    required this.to,
    required this.date,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final TripListModel title;
  final BuildContext buildContext;
  final Function(List<SelectedSeatModel>) onPageChanged;
  final LocationItemModel from, to;
  final String date;

  @override
  State<SeatDetailsPage> createState() => _SeatDetailsPage();
}

class _SeatDetailsPage extends State<SeatDetailsPage> {
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

    startProgressDialog().then((value) => {
    pr.show()
    });
    GetListData(context)
        .getTripSeats(AppUrl.tripListModel.bus_id, widget.from.id, widget.to.id,
            widget.date)
        .then((value) => {
              setState(() {
                seats = value;
              }),pr.hide()
            });
    fares = AppUrl.tripListModel.fares;
  }
  Future<void> startProgressDialog()async{
    await Future.delayed(const Duration(milliseconds: 100), (){});
  }
  int total = 0;

  List<BookingPassengerModel> passengers = [];
  List<SeatItem> seats = [];
  List<FareModel> fares = [];
  List<String> selectedSeats = [];
  List<SelectedSeatModel> selectedSeatsModels = [];

  Widget getSeatItem(String name, SeatItem e) {
    if (name == "Door") {
      return getDoorWidget(
          double.parse(e.seat_height), double.parse(e.seat_width));
    } else if (name == "Driver") {
      return Transform.rotate(
        angle: math.pi / 2,
        child: Icon(
          Icons.pie_chart_outline_sharp,
          size: 40,
        ),
      );
    } else if (name == "Staff") {
      return Container(
        height: double.parse(e.seat_height),
        width: double.parse(e.seat_width),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade700),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.grey,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                e.seat_name,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    } else {
      if (e.selection_status) {
        return Container(
          height: double.parse(e.seat_height),
          width: double.parse(e.seat_width),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: Colors.grey,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  e.seat_name,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        );
      } else {
        return GestureDetector(
          onTap: () {
            int selectionPosition = selectedSeats.indexOf(e.seat_id);
            if (selectedSeats.contains(e.seat_id)) {
              setState(() {
                selectedSeats.remove(e.seat_id);
                total -=  double.parse(
                    selectedSeatsModels[selectionPosition].fareModel.amount)
                    .toInt();
                selectedSeatsModels.removeAt(selectionPosition);
              });
            } else {
              setState(() {
                selectedSeats.add(e.seat_id);
                FareModel fareModel = getFareModel(e);
                selectedSeatsModels.add(SelectedSeatModel(e, fareModel));
                total += double.parse(fareModel.amount).toInt();
              });
            }
          },
          child: Container(
            height: double.parse(e.seat_height),
            width: double.parse(e.seat_width),
            decoration: BoxDecoration(
              border: Border.all(color: getColor(e)[0], width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: getColor(e)[1],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        e.seat_name,
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                Container(
                  child: SizedBox(),
                  height: 5,
                  width: double.parse(e.seat_width),
                  color: getColor(e)[0],
                )
              ],
            ),
          ),
        );
      }
    }
  }

  Widget createSeatsFromList(Size size, double pixelRatio) {
    return Container(
      height: size.height+100,
      width: size.width,
      padding: EdgeInsets.only(right: size.width * .12),
      child: Stack(
        children: seats
            .map((e) => Positioned(
                right: double.parse(e.top),
                top: double.parse(e.left),
                child: getSeatItem(e.seat_name, e)))
            .toList(),
      ),
    );
  }

  Widget getDoorWidget(double width, double height) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade700),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Colors.grey,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "D",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "O",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "O",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "R",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget getDriverWidget(double width, double height) {
    return Icon(
      Icons.pie_chart_outline_sharp,
      size: width,
    );
  }

  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600);
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: selectedSeats.isNotEmpty
            ? Container(
                height: 80,
                width: size.height,
                padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                color: Colors.grey.shade100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Selected: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(selectedSeatsModels
                                .map((e) => e.seat.seat_name)
                                .join(",")
                                .toString())
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Total: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Text("$total KSH")
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          child: Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade800,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text('Next',
                                    style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                              )),
                          onTap: () async {
                            widget.onPageChanged(selectedSeatsModels);
                          },
                        )
                      ],
                    )
                  ],
                ),
              )
            : SizedBox(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  "Select seats to book",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.rubik(textStyle: headline4),
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * .1, right: size.width * .1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: fares.map((e) => getPriceWidget(e)).toList(),
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * .1, right: size.width * .1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade900),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            color: Colors.grey,
                          ),
                          child: SizedBox(),
                        ),
                        const Text("Reserved")
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade700),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            color: Colors.grey.shade100,
                          ),
                          child: const SizedBox(),
                        ),
                        const Text("Available")
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red.shade900),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            color: Colors.red,
                          ),
                          child: SizedBox(),
                        ),
                        const Text("Selected")
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              createSeatsFromList(size, pixelRatio),
              const SizedBox(height: 100.0),
            ])),
          ],
        ));
  }

  Widget getPriceWidget(FareModel fareModel) {
    return Column(
      children: [
        Container(
          height: 30,
          padding: EdgeInsets.only(left: 5, right: 5, top: 5),
          decoration: BoxDecoration(
            border: Border.all(color: getColor2(fareModel.seatType)[0]),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: getColor2(fareModel.seatType)[1],
          ),
          child: Text(
            fareModel.seatType,
            style: TextStyle(color: Colors.white),
          ),
        ),
        Text('${fareModel.amount}${fareModel.currencyCode}')
      ],
    );
  }

  Widget bookingPassengerModelWidget(BookingPassengerModel listModel) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600);
    final TextStyle headline6 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600);
    final TextStyle priceText = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.green, fontSize: 18, fontWeight: FontWeight.w600);
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Container(
          color: Colors.grey.shade100,
          padding: EdgeInsets.only(top: 10.0, bottom: 1, left: 10),
          child: Column(
            children: [
              TextFormField(
                cursorColor: Theme.of(context).primaryColor,
                initialValue: '${listModel.first_name} ${listModel.last_name}',
                readOnly: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.deepOrange,
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: Colors.deepOrange,
                  ),
                  border: InputBorder.none,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  DottedLine(
                    dashColor: Colors.deepOrange,
                    lineLength: 20,
                    direction: Axis.vertical,
                  ),
                ],
              ),
              TextFormField(
                cursorColor: Theme.of(context).primaryColor,
                initialValue: '${listModel.phone}',
                readOnly: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.phone_android,
                    color: Colors.deepOrange,
                  ),
                  labelText: 'Mobile Number',
                  labelStyle: TextStyle(
                    color: Colors.deepOrange,
                  ),
                  border: InputBorder.none,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  DottedLine(
                    dashColor: Colors.deepOrange,
                    lineLength: 20,
                    direction: Axis.vertical,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    cursorColor: Theme.of(context).primaryColor,
                    initialValue: 'Today,10:30am',
                    readOnly: true,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.deepOrange,
                      ),
                      labelText: 'Trip Date',
                      labelStyle: TextStyle(
                        color: Colors.deepOrange,
                      ),
                      border: InputBorder.none,
                    ),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: TextFormField(
                    cursorColor: Theme.of(context).primaryColor,
                    initialValue: '${listModel.ticket_price}',
                    readOnly: true,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.monetization_on,
                        color: Colors.deepOrange,
                      ),
                      labelText: 'Ticket Price',
                      labelStyle: TextStyle(
                        color: Colors.deepOrange,
                      ),
                      border: InputBorder.none,
                    ),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getColor(SeatItem seatColor) {
    if (selectedSeats.contains(seatColor.seat_id)) {
      return [Colors.red.shade900, Colors.red];
    }

    if (seatColor.seat_type == "normal") {
      return [Colors.blue, Colors.grey.shade100];
    } else if (seatColor.seat_type == "bclass") {
      return [Colors.green, Colors.grey.shade100];
    } else {
      return [Colors.yellow, Colors.grey.shade100];
    }
  }

  getColor2(String seatColor) {
    if (seatColor == "normal") {
      return [Colors.blue.shade900, Colors.blue];
    } else if (seatColor == "bclass") {
      return [Colors.green.shade900, Colors.green];
    } else {
      return [Colors.yellow.shade900, Colors.yellow];
    }
  }

  FareModel getFareModel(SeatItem e) {
    FareModel fareModel = FareModel();
    fares.forEach((element) {
      if (e.seat_type == element.seatType) {
        fareModel = element;
      }
    });
    return fareModel;
  }
}
