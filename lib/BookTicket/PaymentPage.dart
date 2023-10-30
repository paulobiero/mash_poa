import 'package:mash/BookTicket/BookTicketBasePage.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key, required this.title,required this.buildContext,required this.onPaymentChosen}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final BuildContext buildContext;
  final Function(String)onPaymentChosen;
  @override
  State<PaymentPage> createState() => _PaymentPage();
}
class _PaymentPage extends State<PaymentPage> {
  bool isLoading=true;
  List<String>paymentMethods=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // GetListData(widget.buildContext).getPaymentMethods().then((value) => {
    // setState(() {
    //    paymentMethods=value;
    //    isLoading=false;
    // })
    // });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    final TextStyle headline4 = Theme
        .of(context)
        .textTheme
        .headline4!
        .copyWith(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w600
    );

    final TextStyle ticketLargeText=Theme.of(context).textTheme.headline2!.copyWith(
      color: Colors.grey.shade800,fontSize: 20,fontWeight: FontWeight.bold,
    );
    final SimpleDialog dialog2 =   SimpleDialog(
      title: Text('Choose payment method'),
      children:paymentMethods.map((e) =>   ListTile(
        title:Text(e),
        onTap: (){
          Navigator.pop(context);
          widget.onPaymentChosen(e);
        },
      )).toList(),
    );
    return Scaffold(
        backgroundColor: Colors.white,

        body: SingleChildScrollView(

          child: isLoading?Column(
            children: [LinearProgressIndicator()],
          ):Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(left: 20, top: 20)
                , child: Text(
                  "Make Payment",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.rubik(textStyle: headline4),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  "Confirm seat reservation",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey),
                  textAlign: TextAlign.left,
                ),),

              const SizedBox(height: 20.0),
              Container(

                margin: EdgeInsets.only(left: 20,right: 20),
                padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                decoration:BoxDecoration(
                  border: Border.all(color: Colors.green.shade200),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color:Colors.green.shade200,

                ),
                child:
                Row(
                  children: [
                    SizedBox(width: 5,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Image.asset('assets/images/QR_code_for_mobile_English_Wikipedia.svg.webp',height: 76,),
                        Text("1234566",style: TextStyle(fontSize: 10),)

                      ],
                    ),
                    SizedBox(width: 17,),
                    Stack(
                        clipBehavior: Clip.none, alignment: Alignment.topCenter,
                        children: <Widget>[
                          Positioned(
                            top: -20,

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
                          DottedLine(dashColor: Colors.white,lineLength: 180,direction: Axis.vertical,),
                          Positioned(
                            bottom: -10,

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
                    SizedBox(width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Super Metro trans",style:GoogleFonts.nunito(textStyle: ticketLargeText),),
                        SizedBox(height: 5,),
                        Text("Trip time",style: TextStyle(fontSize: 13,color: Colors.grey.shade700),),
                        Text(BookTicketBasePage.tripListModel.departure_time,style: TextStyle(fontSize: 15,color: Colors.grey.shade800,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text("From-To",style: TextStyle(fontSize: 13,color: Colors.grey.shade700),),
                        Text("${BookTicketBasePage.fromLocation.name} to ${BookTicketBasePage.toLocation.name}",style: TextStyle(fontSize: 15,color: Colors.grey.shade800,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text("Total Amount",style: TextStyle(fontSize: 13,color: Colors.grey.shade700),),
                        Text("${BookTicketBasePage.passengers.length*double.parse(BookTicketBasePage.tripListModel.fares.first.amount)} ${BookTicketBasePage.tripListModel.fares.first.currencyCode}",style: TextStyle(fontSize: 15,color: Colors.grey.shade800,fontWeight: FontWeight.bold),)
                        ,SizedBox(height: 20,),
                      ],
                    )
                  ],
                ),
              ),
              Container
                (
                margin: EdgeInsets.only(left: 20,right: 20,top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child:  Text("Seats",style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.bold),)),
                    Text("${BookTicketBasePage.passengers.length} x ${BookTicketBasePage.tripListModel.fares.first.amount} ${BookTicketBasePage.tripListModel.fares.first.currencyCode}",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)
                  ],
                ),),

              Container
                (
                margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child:  Text("Tax",style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.bold),)),
                    Text("${BookTicketBasePage.tripListModel.fares.first.tax} ",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)
                  ],
                ),),
              Container
                (
                margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child:  Text("Total",style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.bold),)),
                    Text("${BookTicketBasePage.passengers.length*double.parse(BookTicketBasePage.tripListModel.fares.first.amount)+BookTicketBasePage.tripListModel.fares.first.tax} ${BookTicketBasePage.tripListModel.fares.first.currencyCode}",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)
                  ],
                ),),
              GestureDetector(
                child:  Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                          colors: [
                            Colors.deepOrange,
                            Colors.deepOrange,
                          ]
                      )
                  ),
                  child: const Center(
                    child: Text("Make Payment", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
                onTap: (){
                 // showDialog<void>(context: context, builder: (context) => dialog2);

                },
              )
            ],
          ),
        )
    );
  }
}