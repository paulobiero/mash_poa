import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class BusDetailsPage extends StatefulWidget {
  const BusDetailsPage({Key? key, required this.title,required this.buildContext, required this.onPageChanged}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final BuildContext buildContext;
  final Function() onPageChanged;
  @override
  State<BusDetailsPage> createState() => _BusDetailsPage(this.buildContext,this.onPageChanged);
}
class _BusDetailsPage extends State<BusDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  _BusDetailsPage(this.buildContext,this.onPageChanged);

  BuildContext buildContext;
  Function() onPageChanged;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextStyle headline6 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600
    );
    final TextStyle priceText = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.green,
        fontSize: 18,
        fontWeight: FontWeight.w600
    );
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w600
    );
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(

          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Card(
                elevation: 2,
                margin: EdgeInsets.only(top: 10,left: 20,right: 20),

                child: Container(
                  height: 170,
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.only(top: 1.0,bottom: 1),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Container(

                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Text("Metro Trans",style: GoogleFonts.poppins(textStyle: headline6),),
                            SizedBox(height: 23,),
                            Padding(padding: EdgeInsets.only(left: 10),child:  DottedLine(),),
                            SizedBox(height: 30,),
                            Text("Fri,Jul,22",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.normal),textAlign: TextAlign.start,),
                            Text("10:22 am",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold))

                          ],
                        ),
                      )),
                      Expanded(child:   Container(

                        child: Column(
                          children: [
                            Image.asset('assets/images/Lipanauli_Logo__1_-removebg-preview.png',height: 70,width: 140,),

                            DottedLine(),
                            Container(
                              height: 30,
                              width: 100,
                              margin: EdgeInsets.only(top: 35),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade800),

                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color:Colors.grey.shade100,

                              ),
                              child: Center(
                                child: Text("1hr 10mins", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              ),
                            )
                          ],
                        ),
                      )),
                      Expanded(child:  Container(

                        child:  Column(
                          children: [
                            SizedBox(height: 23,),
                            Text("200ksh",style: GoogleFonts.poppins(textStyle: priceText),),
                            SizedBox(height: 20,),
                            DottedLine(),
                            SizedBox(height: 30,),
                            Text("Fri,Jul,22",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.normal),textAlign: TextAlign.start,),
                            Text("10:22 am",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold))

                          ],
                        ),
                      ))

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(padding: EdgeInsets.only(left: 20,top: 20)
                ,child:  Text(
                  "Trip Details",
                  textAlign: TextAlign.left,
                  style:GoogleFonts.rubik(textStyle: headline4),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 20,top: 10),child:   Text(
                "KAZ 119J",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey),
                textAlign: TextAlign.left,
              ),),
              SizedBox(height: 12,),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                children: [
                  Expanded(child: Card(
                    elevation: 2,
                    margin: EdgeInsets.only(top: 10,left: 20,right: 20),

                    child: Container(
                      height: 100,
                      color: Colors.grey.shade100,
                      padding: EdgeInsets.only(top: 1.0,bottom: 1),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 20,),
                          Expanded(child:  Text("Boarding time ",style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.bold),)),
                          Text("11 00 am",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)
                          ,SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  )),
                  Expanded(child: Card(
                    elevation: 2,
                    margin: EdgeInsets.only(top: 10,left: 20,right: 20),

                    child: Container(
                      height: 100,
                      color: Colors.grey.shade100,
                      padding: EdgeInsets.only(top: 1.0,bottom: 1),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 20,),
                          Expanded(child:  Text("Arrival time ",style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.bold),)),
                          Text("11 50 am",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)
                          ,SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                children: [
                  Expanded(child: Card(
                    elevation: 2,
                    margin: EdgeInsets.only(top: 10,left: 20,right: 20),

                    child: Container(
                      height: 100,
                      color: Colors.grey.shade100,
                      padding: EdgeInsets.only(top: 1.0,bottom: 1),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 20,),
                          Expanded(child:  Text("Vehicle Type ",style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.bold),)),
                          Text("Bus",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)
                          ,SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  )),
                  Expanded(child: Card(
                    elevation: 2,
                    margin: EdgeInsets.only(top: 10,left: 20,right: 20),

                    child: Container(
                      height: 100,
                      color: Colors.grey.shade100,
                      padding: EdgeInsets.only(top: 1.0,bottom: 1),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 20,),
                          Expanded(child:  Text("Boarding location ",style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.bold),)),
                          Text("Athi river stage 39",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)
                          ,SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
              GestureDetector(
                child:  Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          colors: [
                            Colors.green,
                            Colors.green,
                          ]
                      )
                  ),
                  child: Center(
                    child: Text("Choose seats", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
                onTap: (){
                 onPageChanged();
                },
              )
            ],
          ),
        )
    );
  }
}