import 'package:mash/Models/BookingPassengerModel.dart';
import 'package:mash/Models/FaresModel.dart';
import 'package:mash/Models/LocationItemModel.dart';
import 'package:mash/Models/SelectedSeatModel.dart';
import 'package:mash/Models/TripListModel.dart';
import 'package:mash/Services/GetListData.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mash/Utils/Constants.dart';
import 'BookTicketBasePage.dart';

class TicketSearchResultsRound extends StatefulWidget {


  const TicketSearchResultsRound(
      {Key? key,
      required this.travelDate,
      required this.locationTo,
      required this.locationFrom,
      required this.buildContext,
      required this.onPageChanged})
      : super(key: key);


  final String travelDate;
  final BuildContext buildContext;
  final Function(TripListModel) onPageChanged;
  final LocationItemModel locationFrom, locationTo;

  @override
  State<TicketSearchResultsRound> createState() => _TicketSearchResultsRound();
}

class _TicketSearchResultsRound extends State<TicketSearchResultsRound> {
  bool isLoading = true;
  late DateTime newDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GetListData(widget.buildContext)
        .getTripList(
            widget.locationTo.id, widget.locationFrom.id, widget.travelDate)
        .then((value) => {
              setState(() {
                isLoading = false;
                returnData=value;
              })
            });
  }

  List<TripListModel> returnData = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600);
    final TextStyle headline6 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600);
    final TextStyle priceText = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.green, fontSize: 18, fontWeight: FontWeight.w600);

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
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "Choose a return bus",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.rubik(textStyle: headline4),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        "Showing ${returnData.length} results",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ])),
                  returnData.isEmpty
                      ? SliverList(
                          delegate: SliverChildListDelegate([
                          const SizedBox(
                            height: 100,
                          ),
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Text(
                                'No Trips available for the selected locations',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ]))
                      : SliverList(
                          delegate: SliverChildListDelegate(
                              returnData.map((e) => getTripResult(e)).toList()))
                ],
              ));
  }

  Widget getTripResult(TripListModel listModel) {
    final TextStyle headline6 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600);
    final TextStyle priceText = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.blue.shade900, fontSize: 18, fontWeight: FontWeight.w600);

    int length = listModel.amenities.split(',').length > 3
        ? 3
        : listModel.amenities.split(',').length;
    return GestureDetector(
      onTap: () {
        widget.onPageChanged(listModel);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Container(
          padding: const EdgeInsets.only(bottom: 1, left: 10),
          child: Stack(
            children: [
              listModel.highWayDirectRoute == 'Highway'
                  ? Positioned(
                  right: 0,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Colors.black),
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 3, bottom: 3),
                      child: const Text(
                        "High way",
                        style: TextStyle(color: Colors.white),
                      )))
                  : const Positioned(child: SizedBox.shrink()),
              Positioned(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        listModel.trip_code,
                        style: GoogleFonts.poppins(
                          textStyle:
                          headline6.copyWith(color: Colors.grey.shade700),
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: getGridHeight(length),
                                    width: 80,
                                    child: GridView.count(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 2.0,
                                        mainAxisSpacing: 4.0,
                                        children: List.generate(length, (index) {
                                          return Center(
                                            child: AppUrl.getAmenityItem(listModel
                                                .amenities
                                                .split(',')[index]),
                                          );
                                        })),
                                  ),
                                  listModel.amenities.split(',').length > 3
                                      ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        length = listModel.amenities
                                            .split(',')
                                            .length;
                                      });
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: 16,
                                    ),
                                  )
                                      : const SizedBox()
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow.shade900,
                                    size: 18,
                                  ),
                                  Text(
                                      '${listModel.avg_rating}(${listModel.rating_count})')
                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  width: 100,
                                  child: Text(
                                    '${listModel.bus_type}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade700),
                                  ))
                            ],
                          ),
                          Container(
                            width: 140,
                            child: Stack(
                              children: [
                                Positioned(
                                    child: Image.asset(
                                      'assets/images/golden_logo.png',
                                      height: 50,
                                      width: 100,
                                    ))
                              ],
                            ),
                          ),
                          Column(
                            children: listModel.fares.isNotEmpty
                                ? listModel.fares
                                .map((e) => Text(
                              '${e.currencyCode} ${double.parse(e.amount).toInt()}',
                              style: GoogleFonts.poppins(
                                  textStyle: priceText),
                            ))
                                .toList()
                                : [
                              Text(
                                'No fare\n for KSH',
                                style:
                                GoogleFonts.poppins(textStyle: priceText),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const DottedLine(
                        dashColor: Colors.black,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Departure time',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.start,
                              ),
                              Text(listModel.departure_time,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 30,
                                width: 100,
                                margin: EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.pink),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                                  color: Colors.pink,
                                ),
                                child: Center(
                                  child: Text(
                                    '${listModel.available_seat_count} seats',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Arrival time",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.start,
                              ),
                              Text(listModel.arrival_time,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
  double getGridHeight(int length) {
    if (length == 0) {
      return 10;
    } else if (length <= 3) {
      return 30;
    } else {
      return 60;
    }
  }

  String getDateFromTimeStamp(int timeStamp) {
    var date = DateTime.fromMicrosecondsSinceEpoch(timeStamp * 1000);
    return (date.hour > 12 ? (date.hour - 12) : date.hour).toString() +
        ":" +
        date.minute.toString() +
        (date.hour >= 12 ? " PM" : " AM");
  }

  String lowestAndHigestPrices(List<FareModel> fares) {
    fares
        .sort((a, b) => double.parse(a.amount).compareTo(double.parse(b.amount)));
    if (fares.length == 1) {
      return fares.first.amount + " " + fares.first.currencyCode;
    } else {
      FareModel first = fares.first;
      FareModel last = fares.last;

      return first.amount + " - " + last.amount + " " + last.currencyCode;
    }
  }
}
