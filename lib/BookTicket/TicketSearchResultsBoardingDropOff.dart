import 'package:mash/BookTicket/BookTicketBasePage.dart';
import 'package:mash/Models/BookingPassengerModel.dart';
import 'package:mash/Models/LocationItemModel.dart';
import 'package:mash/Services/GetListData.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_text_drawable/flutter_text_drawable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Widgets/pk_search_bar/pk_search_bar.dart';




class TicketSearchResultsBoardingDropOff extends StatefulWidget {
  const TicketSearchResultsBoardingDropOff({Key? key, required this.title,required this.buildContext,required this.from,required this.to, required this.onPageChanged}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final BuildContext buildContext;
  final Function(LocationItemModel,LocationItemModel) onPageChanged;
  final LocationItemModel from,to;
  @override
  State<TicketSearchResultsBoardingDropOff> createState() => _TicketSearchResultsBoardingDropOff();
}
class _TicketSearchResultsBoardingDropOff extends State<TicketSearchResultsBoardingDropOff>with TickerProviderStateMixin {

   late ProgressDialog pr;
   int currentPage=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );

    GetListData(context).getBoardingDroppingPoints(widget.from.id,widget.to.id,widget.title,BookTicketBasePage.tripListModel.bus_id,(list1,list2){

      setState(() {
        suggestions=list1;
        suggestions2=list2;
      });
      pr.hide();
    });
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );
    pr.style(message: "Fetching locations...");
   startProgressDialog().then((value) => {
   pr.show()
   });


  }
   Future<void> startProgressDialog()async{
     await Future.delayed(const Duration(milliseconds: 100), (){});
   }
 bool isLoading=true;
List<LocationItemModel>pickup=[];
List<LocationItemModel>dropOff=[];
LocationItemModel itemModelPickup=LocationItemModel();
LocationItemModel itemModelDroppOff=LocationItemModel();
late TabController tabController;
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox.shrink(),
          toolbarHeight:10 ,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.yellow.shade700,
            tabs: const [
              Tab(text: 'Pick up location'),
              Tab(text: 'Drop Off Location'),

            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            searchBar(context),
            searchBar2(context),
          ],
        ),
      ),

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
   Future<List<LocationItemModel>> search2(String enteredKeyword) async {
     List<LocationItemModel> results = [];
     if (enteredKeyword.isEmpty) {
       // if the search field is empty or only contains white-space, we'll display all users
       results = suggestions2;
     } else {
       results = suggestions2
           .where((user) =>
           user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
           .toList();
       // we use the toLowerCase() method to make it case-insensitive
     }
     print(enteredKeyword);
     setState(() {
       suggestionsCount2=results.length;
     });
     return results;
     // Refresh the UI
   }
  List<LocationItemModel>suggestions=[];
   List<LocationItemModel>suggestions2=[];
  int suggestionsCount=0;
   int suggestionsCount2=0;
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

        if(tabController.index==0)
          {
            itemModelPickup=data;
            tabController.index=1;
          }
        else{
          itemModelDroppOff=data;
          if(itemModelPickup.name.isEmpty)
            {
              tabController.index=0;
            }
          else{
            widget.onPageChanged(itemModelPickup,itemModelDroppOff);
          }
        }

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
      loader: const Center(
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
  Widget searchBar2(BuildContext context) {
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

          Padding(padding: EdgeInsets.only(left: 20,top: 10),child:   Text(
            "Showing ${suggestionsCount2} results",
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
      suggestions: suggestions2,
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
      onSearch: search2,
      loader: const Center(
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