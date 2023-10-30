import 'package:mash/Home/Dialogs/TicketFullDetails.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../Models/TicketModel.dart';
import '../../Services/GetListData.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage(
      {Key? key, required this.title, required this.buildContext})
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

  @override
  State<MyTicketsPage> createState() => _MyTicketsPage(this.buildContext);
}

class _MyTicketsPage extends State<MyTicketsPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    tabController.addListener(() {
      getMyTrips(tabController.index);
    });
    GetListData(context).getRecentTickets("upcoming").then((value) => {
          setState(() {
            trips = value;
            isLoading = false;
          })
        });
  }

  List<TicketModel> trips = [];
  bool isLoading = true;

  _MyTicketsPage(this.buildContext);

  BuildContext buildContext;
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600);
    final TextStyle ticketLargeText =
        Theme.of(context).textTheme.headline2!.copyWith(
              color: Colors.grey.shade800,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            );
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My trips"),
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.yellow.shade700,
            tabs: const [
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: double.infinity),
              margin: EdgeInsets.only(top: 20),
              child: isLoading
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 40, right: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 50,
                          ),
                          CircularProgressIndicator()
                        ],
                      ),
                    )
                  : trips.isNotEmpty
                      ? ListView(
                          children:
                              trips.map((e) => TicketWidget(e, size)).toList(),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 40, right: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                        ),
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: double.infinity),
              margin: EdgeInsets.only(top: 20),
              child: isLoading
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 40, right: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 50,
                          ),
                          CircularProgressIndicator()
                        ],
                      ),
                    )
                  : trips.isNotEmpty
                      ? ListView(
                          children:
                              trips.map((e) => TicketWidget(e, size)).toList(),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 40, right: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/on_4847186.png',
                                height: 130,
                                fit: BoxFit.cover,
                                color: Colors.grey.shade400,
                              ),
                              Text(
                                "It seems you don't have an completed trips",
                                style: ticketLargeText,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: double.infinity),
              margin: EdgeInsets.only(top: 20),
              child: isLoading
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 40, right: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 50,
                          ),
                          CircularProgressIndicator()
                        ],
                      ),
                    )
                  : trips.isNotEmpty
                      ? ListView(
                          children:
                              trips.map((e) => TicketWidget(e, size)).toList(),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/on_4847186.png',
                                height: 130,
                                fit: BoxFit.cover,
                                color: Colors.grey.shade400,
                              ),
                              Text(
                                "It seems you don't have any cancelled trip",
                                style: ticketLargeText,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  void getMyTrips(int index) {
    setState(() {
      isLoading = true;
    });
    String type = "upcoming";
    if (index == 0) {
      type = "upcoming";
    } else if (index == 1) {
      type = "completed";
    } else {
      type = "cancelled";
    }
    GetListData(context).getRecentTickets(type).then((value) => {
          setState(() {
            trips = value;
            isLoading = false;
          })
        });
  }

  Widget TicketWidget(TicketModel model, Size size) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600);
    final TextStyle ticketLargeText =
        Theme.of(context).textTheme.headline2!.copyWith(
              color: Colors.grey.shade700,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            );

    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Container(
          height: 120,
          padding: const EdgeInsets.only(top: 10, left: 10, right: 1),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow.shade200),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.yellow.shade200,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  QrImage(
                    data: model.ticket_number,
                    version: QrVersions.auto,
                    size: 70.0,
                    foregroundColor: Colors.grey.shade700,
                  ),
                  Text(
                    model.ticket_number,
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                  )
                ],
              ),
              SizedBox(
                width: 17,
              ),
              Stack(
                  clipBehavior: Clip.none, alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: -30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(300.0),
                        child: Container(
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DottedLine(
                      dashColor: Colors.grey.shade700,
                      lineLength: 90,
                      direction: Axis.vertical,
                    ),
                    Positioned(
                      bottom: -20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(300.0),
                        child: Container(
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          model.pickup_city.substring(0, 3).toUpperCase(),
                          style: GoogleFonts.nunito(textStyle: ticketLargeText),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        DottedLine(
                          dashColor: Colors.grey.shade700,
                          lineLength: size.width * .1,
                          direction: Axis.horizontal,
                        ),
                        Icon(
                          Icons.directions_bus_sharp,
                          color: Colors.grey.shade700,
                        ),
                        DottedLine(
                          dashColor: Colors.grey.shade700,
                          lineLength: size.width * .1,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          model.drop_city.substring(0, 3).toUpperCase(),
                          style: GoogleFonts.nunito(textStyle: ticketLargeText),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: Text(
                          "${model.boarding_point}",
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 9,
                              fontWeight: FontWeight.normal),
                        ),
                        width: size.width * .15,
                      ),
                      Container(
                        height: 30,
                        width: size.width * .3,
                        padding: EdgeInsets.only(left: 5, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade700),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.yellow.shade200,
                        ),
                        child: Center(
                          child: Text(
                            '${model.total} ${model.currency_code} ${model.status}',
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        child: Text(
                          '${model.booking_date}\n${model.boarding_time}',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 9,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                        width: size.width * .15,
                      ),
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => TicketFullDetails(
                    title: model,
                  ),
              fullscreenDialog: true),
        );
      },
    );
  }
}
