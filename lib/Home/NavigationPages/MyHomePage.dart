import 'package:mash/BookTicket/BookTicketBasePage.dart';
import 'package:mash/Home/NavigationPages/MyTicketsPage.dart';
import 'package:mash/Home/NavigationPages/TicketSearchResultsFrom.dart';
import 'package:mash/Home/NavigationPages/TicketSearchResultsTo.dart';
import 'package:mash/Models/LocationItemModel.dart';
import 'package:mash/Models/TicketModel.dart';
import 'package:mash/Services/GetListData.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mash/BookTicketRound//BookTicketBasePage.dart' as round;
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Dialogs/TicketFullDetails.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.buildContext,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final BuildContext buildContext;

  @override
  State<MyHomePage> createState() => _MyHomePage(this.buildContext);
}

class _MyHomePage extends State<MyHomePage> {
  _MyHomePage(this.buildContext);

  BuildContext buildContext;
  late LocationItemModel fromLocation = LocationItemModel(),
      toLocation = LocationItemModel();
  late DateTime travelDate = DateTime.now(), returnDate;
  bool isReturn = false, isLoading = true;
  List<TicketModel> upcomingTrips = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GetListData(context).getRecentTickets("upcoming").then((value) => {
          setState(() {
            upcomingTrips = value;
            isLoading = false;

          })
        });
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        if (fromLocation.name.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Please choose from location'),
          ));
          return;
        }
        if (toLocation.name.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Please choose To location'),
          ));
          return;
        }
        if (isReturn) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => round.BookTicketBasePage(
                travelDate:
                    '${travelDate.year}-${travelDate.month}-${travelDate.day}',
                returnDate:
                    '${returnDate.year}-${returnDate.month}-${returnDate.day}',
                locationFrom: fromLocation,
                locationTo: toLocation,
                buildContext: context,
                  onPageChanged: (){
                    setState(() {
                      isLoading = true;
                    });
                    GetListData(context).getRecentTickets("upcoming").then((value) => {
                      setState(() {
                        upcomingTrips = value;
                        isLoading = false;

                      })
                    });
                  }
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => BookTicketBasePage(
                travelDate:
                    '${travelDate.year}-${travelDate.month}-${travelDate.day}',
                returnDate: '',
                locationFrom: fromLocation,
                locationTo: toLocation,
                buildContext: context,
                onPageChanged: (){
                  setState(() {
                    isLoading = true;
                  });
                  GetListData(context).getRecentTickets("upcoming").then((value) => {
                    setState(() {
                      upcomingTrips = value;
                      isLoading = false;

                    })
                  });
                },
              ),
            ),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: const <BoxShadow>[],
            color: Colors.orange.shade700),
        child: const Text(
          'Search',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Color background = Colors.black;
    Color fill = Colors.white;
    final List<Color> gradient = [
      background,
      background,
      fill,
      fill,
    ];
    const double fillPercent = 70.23; // fills 56.23% for container from bottom
    const double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600);
    final TextStyle ticketLargeText =
        Theme.of(context).textTheme.headline2!.copyWith(
              color: Colors.grey.shade400,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            );
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                    Container(

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradient,
                          stops: stops,
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            margin: EdgeInsets.only(
                                left: size.width * .03,
                                right: size.width * .03,
                                top: size.height * .06),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                                height: size.height * .44,
                                padding: EdgeInsets.only(
                                    top: 20,
                                    left: size.width * .03,
                                    right: size.width * .03),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: size.height * .2,
                                      width: size.width,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                                children: [
                                                  GestureDetector(
                                                    child: Container(
                                                      height: size.height * .09,
                                                      padding: const EdgeInsets.only(
                                                        left: 10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey.shade300),
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(10)),
                                                        color: Colors.white,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                            "From location",
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            fromLocation.name.isEmpty
                                                                ? "Enter from location"
                                                                : fromLocation.name,
                                                            style: GoogleFonts.rubik(
                                                                textStyle: TextStyle(
                                                                    color: fromLocation
                                                                        .name.isEmpty
                                                                        ? Colors.grey.shade400
                                                                        : Colors.black,
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    fontSize: 18)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext contex) =>
                                                              TicketSearchResultsFrom(
                                                                  title: "title",
                                                                  buildContext: buildContext,
                                                                  onPageChanged:
                                                                      (onPageChanged) {
                                                                    setState(() {
                                                                      fromLocation =
                                                                          onPageChanged;
                                                                    });
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute<void>(
                                                                        builder: (BuildContext
                                                                        context) =>
                                                                            TicketSearchResultsTo(
                                                                              title: "title",
                                                                              buildContext:
                                                                              buildContext,
                                                                              onPageChanged:
                                                                                  (onPageChanged) {
                                                                                setState(() {
                                                                                  toLocation =
                                                                                      onPageChanged;
                                                                                });
                                                                              },
                                                                              fromLocation:
                                                                              fromLocation,
                                                                            ),
                                                                        fullscreenDialog:
                                                                        true,
                                                                      ),
                                                                    );
                                                                  }),
                                                          fullscreenDialog: true,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  GestureDetector(
                                                    child: Container(
                                                      height: size.height * .09,
                                                      padding:
                                                      const EdgeInsets.only(left: 10),
                                                      margin: EdgeInsets.only(top: 10),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey.shade300),
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(10)),
                                                        color: Colors.white,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                            "To location",
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            toLocation.name.isEmpty
                                                                ? "Enter to location"
                                                                : toLocation.name,
                                                            style: GoogleFonts.rubik(
                                                                textStyle: TextStyle(
                                                                    color: toLocation
                                                                        .name.isEmpty
                                                                        ? Colors.grey.shade400
                                                                        : Colors.black,
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    fontSize: 18)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      if (fromLocation.name.isEmpty) {
                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(const SnackBar(
                                                          behavior: SnackBarBehavior.floating,
                                                          content: Text(
                                                              'Please choose from location first'),
                                                        ));
                                                        return;
                                                      }
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext context) =>
                                                              TicketSearchResultsTo(
                                                                title: "title",
                                                                buildContext: buildContext,
                                                                onPageChanged: (onPageChanged) {
                                                                  setState(() {
                                                                    toLocation = onPageChanged;
                                                                  });
                                                                },
                                                                fromLocation: fromLocation,
                                                              ),
                                                          fullscreenDialog: true,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              )),
                                          Positioned(
                                              width: 40,
                                              height: 40,
                                              top: size.height * .07,
                                              right: size.width * .05,
                                              child: GestureDetector(
                                                child: Card(
                                                  elevation: 2,
                                                  color: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(20.0),
                                                  ),
                                                  child: const Icon(
                                                    Icons.swap_vert,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onTap: (){
                                                  if(toLocation.name.isEmpty||fromLocation.name.isEmpty){
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(const SnackBar(
                                                      behavior: SnackBarBehavior.floating,
                                                      content: Text(
                                                          'Please choose from and to location first'),
                                                    ));
                                                    return;
                                                  }
                                                  LocationItemModel temp=LocationItemModel();
                                                  temp=toLocation;
                                                  setState(() {
                                                    toLocation=fromLocation;
                                                    fromLocation=temp;
                                                  });
                                                },
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                            child: GestureDetector(
                                              child: Container(
                                                height: size.height * .09,
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  border:
                                                  Border.all(color: Colors.grey.shade300),
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(10)),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      "Travel date",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      '${travelDate.day}/${travelDate.month}/${travelDate.year}',
                                                      style: GoogleFonts.rubik(
                                                          textStyle: const TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              onTap: () async {
                                                final DateTime? newDate =
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2032, 7),
                                                  helpText: 'Select a date',
                                                );
                                                setState(() {
                                                  travelDate = newDate!;
                                                  isReturn = false;
                                                });
                                              },
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: GestureDetector(
                                              child: Container(
                                                height: size.height * .09,
                                                padding: const EdgeInsets.only(left: 10),
                                                decoration: BoxDecoration(
                                                  border:
                                                  Border.all(color: Colors.grey.shade300),
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(10)),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      "Return date",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      isReturn
                                                          ? '${returnDate.day}/${returnDate.month}/${returnDate.year}'
                                                          : "Enter date",
                                                      style: GoogleFonts.rubik(
                                                          textStyle: TextStyle(
                                                              color: isReturn
                                                                  ? Colors.black
                                                                  : Colors.grey.shade400,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              onTap: () async {
                                                final DateTime? newDate =
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: travelDate,
                                                  firstDate: travelDate,
                                                  lastDate: DateTime(2032, 7),
                                                  helpText: 'Select a date',
                                                );
                                                setState(() {
                                                  returnDate = newDate!;
                                                  isReturn = true;
                                                });
                                              },
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    _submitButton(),
                                  ],
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20, top: 30),
                                child: Text(
                                  "Upcoming trips",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              GestureDetector(
                                child:Padding(
                                  padding: EdgeInsets.only(left: 20, top: 30, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "View all",
                                        style: TextStyle(
                                            color: Colors.yellow.shade700,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.end,
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Colors.yellow.shade700,
                                      )
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(
                                    widget.buildContext,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => MyTicketsPage(title: "", buildContext: context,),

                                    ),
                                  );
                                },
                              ),



                            ],
                          ),
                         isLoading?
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(height: 50,),
                               CircularProgressIndicator()
                              ],
                            ),
                          ):upcomingTrips.isNotEmpty?SizedBox(height: 20,):
                         Padding(
                           padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children:  [
                               Image.asset(
                                 'assets/images/on_4847186.png',
                                 height: 130,
                                 fit: BoxFit.cover,
                                 color: Colors.grey.shade400,
                               ),
                               Text(
                                 "It seems you don't have an upcoming trip,search trip to add one",
                                 style: ticketLargeText,
                                 textAlign: TextAlign.center,
                               )
                             ],
                           ),
                         )
                        ],
                      ),
                    )
                  ])
              ),
             isLoading?SliverList(delegate: SliverChildListDelegate([]),):upcomingTrips.isNotEmpty? SliverList(delegate: SliverChildListDelegate(upcomingTrips.map((e) => TicketWidget(e,size)).toList())):SliverList(delegate: SliverChildListDelegate([

             ]),)

            ]));
  }

  Widget TicketWidget(TicketModel model,Size size){
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w600
    );
    final TextStyle ticketLargeText=Theme.of(context).textTheme.headline2!.copyWith(
      color: Colors.grey.shade700,fontSize: 25,fontWeight: FontWeight.bold,
    );

    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
        child: Container(
          height: 120,

          padding: const EdgeInsets.only(top: 10,left: 10,right: 1),
          decoration:BoxDecoration(
            border: Border.all(color: Colors.yellow.shade200),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color:Colors.yellow.shade200,

          ),
          child:
          Row(
            children: [
              SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  QrImage(
                    data: model.ticket_number,
                    version: QrVersions.auto,
                    size: 70.0,
                    foregroundColor: Colors.grey.shade700,
                  ),
                   Text(model.ticket_number,style: TextStyle(fontSize: 10,color: Colors.grey.shade700),)

                ],
              ),
              SizedBox(width: 17,),
              Stack(
                  clipBehavior: Clip.none, alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: -30,

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(300.0),
                        child:Container(
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                    ,
                    DottedLine(dashColor: Colors.grey.shade700,lineLength: 90,direction: Axis.vertical,),
                    Positioned(
                      bottom: -20,

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(300.0),
                        child:Container(
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]),
              SizedBox(width: 10,),
              Column(
                children: [

                 Expanded(
                   child:  Row(
                     children: [
                       Text(model.pickup_city.substring(0,3).toUpperCase(),style:GoogleFonts.nunito(textStyle: ticketLargeText),),
                       SizedBox(width: 5,),
                       DottedLine(dashColor: Colors.grey.shade700,lineLength: size.width*.1,direction: Axis.horizontal,),
                       Icon(Icons.directions_bus_sharp,color: Colors.grey.shade700,),
                       DottedLine(dashColor: Colors.grey.shade700,lineLength: size.width*.1,direction: Axis.horizontal,),
                       SizedBox(width: 5,),
                       Text(model.drop_city.substring(0,3).toUpperCase(),style:GoogleFonts.nunito(textStyle: ticketLargeText),)
                     ],
                   ),
                 ),
                  Expanded(child:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(

                        child:  Text("${model.boarding_point}",style: TextStyle(color: Colors.grey.shade700,fontSize: 9,fontWeight: FontWeight.normal),),
                        width: size.width*.15,
                      ),
                      Container(
                        height: 30,
                        width: size.width*.3,
                        padding: EdgeInsets.only(left: 5,right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade700),

                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color:Colors.yellow.shade200,

                        ),
                        child:  Center(
                          child: Text('${model.total} ${model.currency_code} ${model.status}', style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.bold,fontSize: 10),),
                        ),
                      ),
                      const SizedBox(width: 5,),
                       SizedBox(
                        child: Text('${model.booking_date}\n${model.boarding_time}',style: TextStyle(color: Colors.grey.shade700,fontSize: 9,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
                        width: size.width*.15,
                      ),
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => TicketFullDetails(title: model,),
            fullscreenDialog: true

          ),
        );
      },
    );
  }
}
