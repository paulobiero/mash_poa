import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w600
    );
    final TextStyle ticketLargeText=Theme.of(context).textTheme.headline2!.copyWith(
      color: Colors.grey.shade200,fontSize: 25,fontWeight: FontWeight.bold,
    );
    return GestureDetector(
      child: Card(
        child: Container(
          height: 120,
          margin: const EdgeInsets.only(left: 10,right: 10,top: 20),
          padding: const EdgeInsets.only(top: 10,left: 10,right: 1),
          decoration:BoxDecoration(
            border: Border.all(color: Colors.black87),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color:Colors.black87,

          ),
          child:
          Row(
            children: [
              SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Image.asset('assets/images/QR_code_for_mobile_English_Wikipedia.svg.webp',height: 76,color: Colors.white,),
                  Text("1234566",style: TextStyle(fontSize: 10,color: Colors.white),)

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
                    DottedLine(dashColor: Colors.white,lineLength: 90,direction: Axis.vertical,),
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
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("CBD",style:GoogleFonts.nunito(textStyle: ticketLargeText),),
                      SizedBox(width: 5,),
                      DottedLine(dashColor: Colors.grey.shade200,lineLength: 30,direction: Axis.horizontal,),
                      Icon(Icons.directions_bus_sharp,color: Colors.grey.shade200,),
                      DottedLine(dashColor: Colors.grey.shade200,lineLength: 30,direction: Axis.horizontal,),
                      SizedBox(width: 5,),
                      Text("ART",style:GoogleFonts.nunito(textStyle: ticketLargeText),)
                    ],
                  ),
                  Expanded(child:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(

                        child: const Text("Nairobi city\n Railways",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.normal),),
                        width: 70,
                      ),
                      Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),

                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color:Colors.black87,

                        ),
                        child: const Center(
                          child: Text("200ksh", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      const SizedBox(width: 15,),
                      const SizedBox(
                        child: Text("Athi river\n 39 stage",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.normal),),
                        width: 70,
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

      },
    );
  }


}