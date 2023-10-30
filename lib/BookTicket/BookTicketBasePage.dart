import 'package:mash/BookTicket/ChoosePaymentMethod.dart';
import 'package:mash/BookTicket/PassengerInfo.dart';
import 'package:mash/BookTicket/PaymentPage.dart';
import 'package:mash/BookTicket/SeatDetailsPage.dart';
import 'package:mash/BookTicket/TicketSearchResults.dart';
import 'package:mash/BookTicket/TicketSearchResultsBoardingDropOff.dart';
import 'package:mash/Models/LocationItemModel.dart';
import 'package:mash/Models/SelectedSeatModel.dart';
import 'package:mash/Models/TripListModel.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../Models/BookingPassengerModel.dart';




class BookTicketBasePage extends StatefulWidget {
  static LocationItemModel fromLocation=LocationItemModel();
  static LocationItemModel toLocation=LocationItemModel();
  static LocationItemModel pickLocation=LocationItemModel();
  static LocationItemModel dropLocation=LocationItemModel();
  static TripListModel tripListModel=TripListModel();
  static List<SelectedSeatModel> passengers=[];
  static List<BookingPassengerModel>bookings=[];
  final Function() onPageChanged;


  static String selectedDate="";
  static String email="";

  static String booking_reference="";
  const BookTicketBasePage({Key? key, required this.travelDate,required this.returnDate,required this.locationFrom,required this.locationTo,required this.buildContext,required this.onPageChanged}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String travelDate,returnDate;
  final BuildContext buildContext;
  final LocationItemModel locationFrom,locationTo;
  @override
  State<BookTicketBasePage> createState() => _BookTicketBasePage(this.buildContext);
}
class _BookTicketBasePage extends State<BookTicketBasePage>with TickerProviderStateMixin {

  late final ProgressDialog pr;
  TripListModel tripListModel=TripListModel();
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {
        currentPage=tabController.index;
        print("current page $currentPage}");
      });
    });
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false,);
    pr.style(message: "Please wait");
    super.initState();

  }
  int currentPage=0;
  _BookTicketBasePage(this.buildContext);

  BuildContext buildContext;
  late TabController tabController;
  LocationItemModel fromLocation=LocationItemModel();
  List<SelectedSeatModel>selected=[];
  Future<void>setTripDetails(TripListModel trip)async{
     setState(() {
       tripListModel=trip;
     });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w600
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title:Column(
            children: [
              SizedBox(height: 30,),
              DotsIndicator(dotsCount: 5,position: currentPage.toDouble(),)
            ],
          ),
          elevation: 0,iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        ),

        body: TabBarView(
          controller:tabController ,
          physics: NeverScrollableScrollPhysics(),
          children: [
            TicketSearchResults(travelDate:widget.travelDate,buildContext: context,onPageChanged: (t){

              BookTicketBasePage.tripListModel=t;
              setTripDetails(t).then((value) => {
              tabController.index=1
              });



            }, locationFrom: widget.locationFrom,locationTo: widget.locationTo,),
            SeatDetailsPage(title:BookTicketBasePage.tripListModel,buildContext: context,onPageChanged: (list){
              tabController.index=2;
              selected=list;
              BookTicketBasePage.passengers=list;
            },from: widget.locationFrom,to: widget.locationTo,date: widget.travelDate,),
            TicketSearchResultsBoardingDropOff(title: widget.travelDate, buildContext: buildContext,from: widget.locationFrom,to: widget.locationTo, onPageChanged: (s,s1){
              BookTicketBasePage.pickLocation=s;
              BookTicketBasePage.dropLocation=s1;
              tabController.index=3;
            }),

            PassengerInfo(title: 'title', buildContext: buildContext, onPageChanged: (s){
              BookTicketBasePage.bookings=s;
              tabController.index=4;
            }, seats: selected,to: widget.locationTo,from: widget.locationFrom,),
            ChoosePaymentMethod(title: widget.travelDate,to: widget.locationTo,from: widget.locationFrom,buildContext: context,onPaymentChosen: (pay){
             pr.show();

            },widget: widget,),
          ],
        )



    );
  }
}