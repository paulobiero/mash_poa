import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MyTripsPage extends StatefulWidget {
  const MyTripsPage({Key? key, required this.title,required this.buildContext,}) : super(key: key);

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
  State<MyTripsPage> createState() => _MyTripsPage(this.buildContext);
}
class _MyTripsPage extends State<MyTripsPage> {
  _MyTripsPage(this.buildContext);

  BuildContext buildContext;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
        body: SingleChildScrollView(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Padding(padding: EdgeInsets.only(left: 20,top: 20)
          ,child:  Text(
          "Search Bus",
          textAlign: TextAlign.left,
          style:GoogleFonts.rubik(textStyle: headline4),
        ),
        ),
        Padding(padding: EdgeInsets.only(left: 20,top: 10),child:   Text(
          "Are you planning a trip?",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey),
          textAlign: TextAlign.left,
        ),),

              Card(
                elevation: 0,
                margin: EdgeInsets.only(top: 10,left: 20,right: 20),

                child: Container(
                  padding: EdgeInsets.only(top: 1.0,bottom: 1),

                  child: Column(

                    children: [
                      Image.asset('assets/images/—Pngtree—vector bus station_808798.png',width: 200,),
                      TextFormField(
                        cursorColor: Theme.of(context).primaryColor,
                        initialValue: 'CBD Nairobi',
                     readOnly: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.location_on,color: Colors.green,),
                          labelText: 'From',
                          labelStyle: TextStyle(
                            color: Colors.green,
                          ),

                          border: InputBorder.none,
                        ),
                      )
                     ,
                      Row(
                        children: [
                          SizedBox(width: 12,),
                          DottedLine(dashColor: Colors.green,lineLength: 40,direction: Axis.vertical,),
                        ],
                      ),
                      TextFormField(
                        cursorColor: Theme.of(context).primaryColor,
                        initialValue: 'Athi river',
                        readOnly: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.my_location,color: Colors.green,),
                          labelText: 'To',
                          labelStyle: TextStyle(
                            color: Colors.green,
                          ),

                          border: InputBorder.none,
                        ),
                      )
                      ,
                      Row(
                        children: [
                          SizedBox(width: 12,),
                          DottedLine(dashColor: Colors.green,lineLength: 40,direction: Axis.vertical,),
                        ],
                      ),
                     Row(
                       children: [
                         Expanded(child:   TextFormField(
                           cursorColor: Theme.of(context).primaryColor,
                           initialValue: 'Today,10:30am',
                           readOnly: true,
                           decoration: InputDecoration(
                             icon: Icon(Icons.date_range,color: Colors.green,),
                             labelText: 'Trip Date',
                             labelStyle: TextStyle(
                               color: Colors.green,
                             ),

                             border: InputBorder.none,
                           ),
                         ))
                       ,
                         Expanded(child: TextFormField(
                           cursorColor: Theme.of(context).primaryColor,
                           initialValue: '1',
                           readOnly: true,
                           decoration: InputDecoration(
                             icon: Icon(Icons.people,color: Colors.green,),
                             labelText: 'Passengers',
                             labelStyle: TextStyle(
                               color: Colors.green,
                             ),

                             border: InputBorder.none,
                           ),
                         ))
                       ],
                     ),
                      GestureDetector(
                        child:  Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.green,
                                    Colors.green,
                                  ]
                              )
                          ),
                          child: Center(
                            child: Text("Search Trip", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        ),
                        onTap: (){

                        },
                      )
                     ],
                  ),
                ),
              )
              ,
              Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 30
              ),child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Today's Schedule ▾",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                  Text("See All",style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold))
                ],
              ),),
             Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     Icon(Icons.pending_actions,color: Colors.grey.shade600,),
                     SizedBox(width: 10,),
                     Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("Town via mombasa road",style: TextStyle(color:  Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500)),
                         Text("31st may 2022",textAlign: TextAlign.start,style: TextStyle(fontSize: 13,color: Colors.grey.shade700),)
                       ],
                     )
                   ],
                 ),
                 Icon(Icons.more_vert),
               ],
             ),

             ),
              Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.pending_actions,color: Colors.grey.shade600,),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Ngong Road professional center",style: TextStyle(color:  Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500)),
                            Text("31st may 2022",textAlign: TextAlign.start,style: TextStyle(fontSize: 13,color: Colors.grey.shade700),)
                          ],
                        )
                      ],
                    ),
                    Icon(Icons.more_vert),
                  ],
                ),

              ),
              Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.pending_actions,color: Colors.grey.shade600,),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Capital center mombasa road",style: TextStyle(color:  Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500)),
                            Text("3rd may 2022",textAlign: TextAlign.start,style: TextStyle(fontSize: 13,color: Colors.grey.shade700),)
                          ],
                        )
                      ],
                    ),
                    Icon(Icons.more_vert),
                  ],
                ),

              ),
              Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.pending_actions,color: Colors.grey.shade600,),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Kca University via thika",style: TextStyle(color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500)),
                            Text("4th may 2022",textAlign: TextAlign.start,style: TextStyle(fontSize: 13,color: Colors.grey.shade700),)
                          ],
                        )
                      ],
                    ),
                    Icon(Icons.more_vert),
                  ],
                ),

              ),

              Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 30
              ),child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("My Favourites",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                  Text("See All",style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold))
                ],
              ),),
              Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite,color: Colors.grey.shade600,),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Town via mombasa road",style: TextStyle(color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500)),
                            ],
                        )
                      ],
                    ),

                  ],
                ),

              ),
              Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite,color: Colors.grey.shade600,),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Britam Towers",style: TextStyle(color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500)),
                          ],
                        )
                      ],
                    ),

                  ],
                ),

              ),
              Padding(padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite,color: Colors.grey.shade600,),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Kilimani rest house",style: TextStyle(color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500)),
                          ],
                        )
                      ],
                    ),

                  ],
                ),

              ),
              Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 30
              ),child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Recently Visited",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                  Text("See All",style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold))
                ],
              ),),
              SizedBox(height: 200,),
            ],
          ),
        )
    );
  }
}