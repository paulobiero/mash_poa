

import 'package:mash/BookTicketRound/SeatDetailsPageRound.dart';
import 'package:mash/BookTicketRound/TicketSearchResultsBoardingDropOffRound.dart';
import 'package:mash/Models/BookingPassengerModel.dart';
import 'package:mash/Models/LocationItemModel.dart';
import 'package:mash/Models/SelectedSeatModel.dart';
import 'package:mash/Models/TripListModel.dart';
import 'package:mash/Utils/Constants.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'ChoosePaymentMethod.dart';
import 'PassengerInfo.dart';
import 'SeatDetailsPage.dart';
import 'TicketSearchResults.dart';
import 'TicketSearchResultsBoardingDropOff.dart';
import 'TicketSearchResultsRound.dart';

class BookTicketBasePage extends StatefulWidget {


  const BookTicketBasePage(
      {Key? key,
      required this.travelDate,
      required this.returnDate,
      required this.locationFrom,
      required this.locationTo,
      required this.buildContext,
        required this.onPageChanged
      })
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String travelDate, returnDate;
  final BuildContext buildContext;
  final LocationItemModel locationFrom, locationTo;
  final Function() onPageChanged;

  @override
  State<BookTicketBasePage> createState() =>
      _BookTicketBasePage(this.buildContext);
}

class _BookTicketBasePage extends State<BookTicketBasePage>
    with TickerProviderStateMixin {
  late final ProgressDialog pr;

  Future<void>setTripDetails(TripListModel trip)async{
    AppUrl.tripListModelReturn=trip;


  }
  @override
  void activate() {
    // TODO: implement activate
    super.activate();
    print('Activate...');
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose...');
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate...');
  }
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(
      initialIndex: 7,
      length: 8,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {
        currentPage = tabController.index;
        print("current page $currentPage}");
      });
    });
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );
    pr.style(message: "Please wait");
    super.initState();
  }

  int currentPage = 0;

  _BookTicketBasePage(this.buildContext);

  BuildContext buildContext;
  late TabController tabController;
  LocationItemModel fromLocation = LocationItemModel();



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              DotsIndicator(
                dotsCount: 8,
                position: currentPage.toDouble(),
                onTap: (position) {
                  tabController.index = position.toInt();
                },
              )
            ],
          ),
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            TicketSearchResults(
              travelDate: widget.travelDate,
              buildContext: context,
              onPageChanged: (t) {
                AppUrl.tripListModel = t;
                tabController.index = 1;
              },
              locationFrom: widget.locationFrom,
              locationTo: widget.locationTo,
            ),
            SeatDetailsPage(
              title: AppUrl.tripListModel,
              buildContext: context,
              onPageChanged: (list) {
                tabController.index = 2;

                AppUrl.passengers = list;
              },
              from: widget.locationFrom,
              to: widget.locationTo,
              date: widget.travelDate,
            ),
            TicketSearchResultsBoardingDropOff(
                title: widget.travelDate,
                buildContext: buildContext,
                from: widget.locationFrom,
                to: widget.locationTo,
                onPageChanged: (s, s1) {
                  AppUrl.pickLocation = s;
                  AppUrl.dropLocation = s1;
                  tabController.index = 3;
                }),
            TicketSearchResultsRound(
              travelDate: widget.returnDate,
              buildContext: context,
              onPageChanged: (t) {
                setTripDetails(t).then((value) => {
                tabController.index = 4
                });

              },
              locationFrom: widget.locationFrom,
              locationTo: widget.locationTo,
            ),
            SeatDetailsPageRound(
              title: AppUrl.tripListModelReturn,
              buildContext: context,
              onPageChanged: (list) {
                tabController.index = 5;
                AppUrl.passengersReturn = list;
              },
              from: widget.locationTo,
              to: widget.locationFrom,
              date: widget.returnDate,
            ),
            TicketSearchResultsBoardingDropOffRound(
                title: widget.returnDate,
                buildContext: buildContext,
                from: widget.locationTo,
                to: widget.locationFrom,
                onPageChanged: (s, s1) {
                  AppUrl.pickLocationReturn = s;
                  AppUrl.dropLocationReturn = s1;
                  tabController.index = 6;
                }),
            PassengerInfo(
              title: 'title',
              buildContext: buildContext,
              onPageChanged: (s,s2) {
                AppUrl.bookings = s;
                AppUrl.bookingsReturn = s2;
                tabController.index = 7;
              },
              seats: AppUrl.passengers,
              to: widget.locationTo,
              from: widget.locationFrom,
            ),
            ChoosePaymentMethod(
                title: widget.travelDate,
                to: widget.locationTo,
                from: widget.locationFrom,
                returnDate: widget.returnDate,
                buildContext: context,
                onPaymentChosen: (pay) {
                  pr.show();
                },widget: widget,),
          ],
        ));
  }
}
