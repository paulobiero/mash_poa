import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class TripHistoryPage extends StatefulWidget {
  const TripHistoryPage({Key? key, required this.title,required this.buildContext}) : super(key: key);

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
  State<TripHistoryPage> createState() => _TripHistoryPage(this.buildContext);
}
class _TripHistoryPage extends State<TripHistoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  _TripHistoryPage(this.buildContext);

  BuildContext buildContext;
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
                  "My Trip History",
                  textAlign: TextAlign.left,
                  style:GoogleFonts.rubik(textStyle: headline4),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 20,top: 10),child:   Text(
                "From Nov 13 to Nov 16",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey),
                textAlign: TextAlign.left,
              ),),

              const SizedBox(height: 20.0),

            ],
          ),
        )
    );
  }
}