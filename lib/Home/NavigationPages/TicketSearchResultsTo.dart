import 'package:mash/Services/GetListData.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_text_drawable/flutter_text_drawable.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Models/LocationItemModel.dart';
import '../../Widgets/pk_search_bar/pk_search_bar.dart';




class TicketSearchResultsTo extends StatefulWidget {
  const TicketSearchResultsTo({Key? key, required this.title,required this.buildContext, required this.onPageChanged,required this.fromLocation}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final BuildContext buildContext;
  final LocationItemModel fromLocation;
  final Function(LocationItemModel) onPageChanged;
  @override
  State<TicketSearchResultsTo> createState() => _TicketSearchResults(this.buildContext,this.onPageChanged,this.fromLocation);
}
class _TicketSearchResults extends State<TicketSearchResultsTo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GetListData(context).getAllCities(int.parse(fromLocation.id), "destination").then((value) => {
    setState(() {
isLoading=false;
suggestions=value;
suggestionsCount=suggestions.length;
    })
    });
  }
 bool isLoading=true;
  _TicketSearchResults(this.buildContext,this.onPageChanged,this.fromLocation);
   Function(LocationItemModel) onPageChanged;
  final LocationItemModel fromLocation;
  BuildContext buildContext;
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

    final TextStyle ticketLargeText=Theme.of(context).textTheme.headline2!.copyWith(
      color: Colors.grey.shade800,fontSize: 25,fontWeight: FontWeight.bold,
    );
    final TextStyle ticketLargeText2=Theme.of(context).textTheme.headline2!.copyWith(
      color: Colors.green,fontSize: 18,fontWeight: FontWeight.normal,
    );
    final TextStyle ticketLargeText3=Theme.of(context).textTheme.headline2!.copyWith(
      color: Colors.grey.shade800,fontSize: 18,fontWeight: FontWeight.normal,
    );
    final TextStyle ticketLargeText4=Theme.of(context).textTheme.headline2!.copyWith(
      color: Colors.blue,fontSize: 18,fontWeight: FontWeight.normal,
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(''),
          elevation: 0,iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        ),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        body: isLoading?Column(
          children: [
            LinearProgressIndicator()
          ],
        ):searchBar(buildContext)
    );
  }
  Future<List<LocationItemModel>> search(String enteredKeyword) async {
    List<LocationItemModel> results = [];
     if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = suggestions;
    } else {
      results = suggestions
          .where((user) =>
          user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
     print(enteredKeyword);
     setState(() {
       suggestionsCount=results.length;
     });
    return results;
    // Refresh the UI
  }
  List<LocationItemModel>suggestions=[];
  int suggestionsCount=0;
  Widget searchResults(LocationItemModel data){
    return GestureDetector(
      child: Container(

        margin: EdgeInsets.only(left: 10,right: 10),
        padding: EdgeInsets.only(top: 10,left: 10,right: 10),

        child:
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                TextDrawable(
                  text: "data.name",
                  textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  isTappable: true,
                  onTap: (val) {

                  },
                  boxShape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                ),


              ],
            ),
            SizedBox(width: 17,),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(data.name,style:Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.grey.shade800,fontSize: 18,fontWeight: FontWeight.w500,
                ),),

              ],
            ),
            Expanded(child: Column(

              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                SizedBox(height: 5,),
                Icon(Icons.chevron_right)

              ],
            ))
          ],
        ),
      ),
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
        onPageChanged(data);
        Navigator.pop(context);
      },
    );
  }
  Widget searchBar(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w600
    );
    return SearchBar<LocationItemModel>(
      header: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 20,top: 20)
            ,child:  Text(
              "To location",
              textAlign: TextAlign.left,
              style:GoogleFonts.rubik(textStyle: headline4),
            ),
          ),
           Padding(padding: EdgeInsets.only(left: 20,top: 10),child:   Text(
            "Showing ${suggestionsCount} results",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey),
            textAlign: TextAlign.left,
          ),),

        ],
      ),
      searchBarPadding: EdgeInsets.only(left: 20, right: 5, top: 10, bottom: 5),
      headerPadding: EdgeInsets.only(left: 0, right: 0),
      listPadding: EdgeInsets.only(left: 0, right: 0),
      hintStyle: TextStyle(
        color: Colors.black54,
      ),
      textStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),

      iconActiveColor: Colors.deepPurple,
      shrinkWrap: true,
      mainAxisSpacing: 10,
      crossAxisSpacing: 5,
      suggestions: suggestions,
      cancellationWidget: Icon(Icons.cancel_sharp),
      minimumChars: 1,
//      placeHolder: Center(
//        child: Padding(
//          padding: const EdgeInsets.only(left: 10, right: 10),
//          child: Text(searchMessage, textAlign: TextAlign.center, style: CustomTextStyle.textSubtitle1(context).copyWith(fontSize: 14),),
//        ),
//      ),
      emptyWidget: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text("There is no any data found"),
        ),
      ),
      onError: (error) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text("$error", textAlign: TextAlign.center),
          ),
        );
      },
      onSearch: search,
      loader: Center(
        child: CircularProgressIndicator(),
      ),/// CountrySearch  // if want to search with API then use thi ----> getCountryListFromApi
      onCancelled: () {
        Navigator.pop(context);
      },
      buildSuggestion: (LocationItemModel countryModel, int index) {
        return searchResults(countryModel);
      },
      onItemFound: (LocationItemModel countryModel, int index) {
        return searchResults(countryModel);
      },
    );
  }
}